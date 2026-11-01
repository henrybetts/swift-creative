import CGLFW

/// A native window.
///
/// A window opens when created, is added to `App.windows`, and stays open until either `close()` or
/// `App.quit()` is called. Once closed, setting properties has no effect and getting them returns undefined
/// values.
@MainActor
public final class Window {
    private var handle: OpaquePointer?
    private var storedTitle: String

    /// Opens a window with the given title and size in screen coordinates.
    ///
    /// Must be called while `App.run(_:)` is executing.
    public init(title: String, size: Size2D) {
        precondition(App.isRunning, "Windows can only be created while App.run(_:) is executing")

        glfwDefaultWindowHints()
        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API)
        guard let handle = glfwCreateWindow(Int32(size.width.rounded()), Int32(size.height.rounded()), title, nil, nil)
        else {
            fatalError("Failed to create window: \(App.lastGLFWError)")
        }
        self.handle = handle
        storedTitle = title

        glfwSetWindowUserPointer(handle, Unmanaged.passUnretained(self).toOpaque())
        glfwSetWindowCloseCallback(handle) { handle in
            MainActor.assumeIsolated { Window.from(handle)?.close() }
        }
        App.addWindow(self)
    }

    /// Whether the window is open.
    public var isOpen: Bool {
        handle != nil
    }

    /// The title shown in the window's title bar.
    public var title: String {
        get { storedTitle }
        set {
            guard let handle else { return }
            storedTitle = newValue
            glfwSetWindowTitle(handle, newValue)
        }
    }

    /// The size of the window's content area in screen coordinates.
    public var size: Size2D {
        get {
            guard let handle else { return .zero }
            var width: Int32 = 0
            var height: Int32 = 0
            glfwGetWindowSize(handle, &width, &height)
            return Size2D(Float(width), Float(height))
        }
        set {
            guard let handle else { return }
            glfwSetWindowSize(handle, Int32(newValue.width.rounded()), Int32(newValue.height.rounded()))
        }
    }

    /// Closes the window and removes it from `App.windows`. Has no effect if the window is already closed.
    public func close() {
        guard let handle else { return }
        glfwDestroyWindow(handle)
        self.handle = nil
        App.removeWindow(self)
    }

    /// Returns the window for a GLFW window handle.
    private static func from(_ handle: OpaquePointer?) -> Window? {
        glfwGetWindowUserPointer(handle).map { Unmanaged<Window>.fromOpaque($0).takeUnretainedValue() }
    }
}
