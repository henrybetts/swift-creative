import CWebGPU
import WebGPU

/// A GPU device, which creates and owns rendering resources.
///
/// Most GPU resources automatically use the shared `Device.default`, which is available while `App.run(_:)` or
/// `Device.withDefault(_:)` is executing.
@MainActor
public final class Device {
    /// The shared default device.
    ///
    /// Must be accessed while `App.run(_:)` or `Device.withDefault(_:)` is executing.
    public static var `default`: Device {
        guard let _default else {
            preconditionFailure("Device.default can only be used while App.run(_:) or Device.withDefault(_:) is executing")
        }
        return _default
    }

    /// The default device, if `withDefault(_:)` is executing.
    private(set) static var _default: Device?

    let instance: Instance
    let adapter: Adapter
    let device: WebGPU.Device

    /// Creates a device using the system's default adapter.
    private init() throws(DeviceError) {
        instance = createInstance(descriptor: InstanceDescriptor(requiredFeatures: [.timedWaitAny]))

        var adapterResult: Result<Adapter, RequestError<RequestAdapterStatus>>?
        instance.wait(for: instance.requestAdapter(callbackMode: .waitAnyOnly) { adapterResult = $0 })
        switch adapterResult! {
        case .success(let adapter): self.adapter = adapter
        case .failure(let error): throw .adapterUnavailable(message: error.description)
        }

        var deviceResult: Result<WebGPU.Device, RequestError<RequestDeviceStatus>>?
        let descriptor = DeviceDescriptor(
            deviceLostCallback: Device.deviceLost,
            uncapturedErrorCallback: Device.uncapturedError)
        instance.wait(for: adapter.requestDevice(descriptor: descriptor, callbackMode: .waitAnyOnly) { deviceResult = $0 })
        switch deviceResult! {
        case .success(let device): self.device = device
        case .failure(let error): throw .deviceUnavailable(message: error.description)
        }
    }

    /// Calls `body` with the default device available, creating it if needed.
    ///
    /// A device created by this call is destroyed when it returns. Nested calls reuse the existing device. `App.run(_:)`
    /// calls this for you.
    ///
    /// Throws a `DeviceError` if a device can't be created, or rethrows any error thrown by `body`.
    public static func withDefault<Result>(_ body: () throws -> Result) throws -> Result {
        if _default != nil {
            return try body()
        }
        let device = try Device()
        _default = device
        defer {
            _default = nil
            device.device.destroy()
        }
        return try body()
    }

    /// Handles loss of the device, which may be reported on any thread.
    nonisolated private static func deviceLost(_ device: UnsafePointer<WGPUDevice?>, reason: DeviceLostReason, message: String) {
        switch reason {
        case .destroyed, .callbackCancelled: break
        default: print("GPU device lost (\(reason)): \(message)")
        }
    }

    /// Handles a GPU error that wasn't otherwise captured, which may be reported on any thread.
    nonisolated private static func uncapturedError(_ device: UnsafePointer<WGPUDevice?>, type: ErrorType, message: String) {
        print("GPU error (\(type)): \(message)")
    }
}

/// An error that occurs when creating a GPU device.
public enum DeviceError: Error, CustomStringConvertible {
    /// No suitable GPU adapter is available.
    case adapterUnavailable(message: String)
    /// The adapter failed to create a device.
    case deviceUnavailable(message: String)

    public var description: String {
        switch self {
        case .adapterUnavailable(let message): "No GPU adapter available: \(message)"
        case .deviceUnavailable(let message): "Failed to create a GPU device: \(message)"
        }
    }
}

extension Instance {
    /// Blocks until `future` completes.
    fileprivate func wait(for future: Future) {
        var info = WGPUFutureWaitInfo(future: WGPUFuture(id: future.id), completed: WGPUBool(0))
        let status = waitAny(futureCount: 1, futures: &info, timeoutNs: .max)
        precondition(status == .success, "Failed to wait for a WebGPU future (\(status))")
    }
}
