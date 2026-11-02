import CGLFW

/// A native window.
///
/// A window opens when created, is added to `App.windows`, and stays open until the user closes it or
/// `close()` or `App.quit()` is called. Once closed, setting properties has no effect and getting them
/// returns undefined values.
@MainActor
public final class Window {
    private var handle: OpaquePointer?
    private var storedTitle: String

    /// Occurs when the mouse cursor moves, with the new `mousePosition`.
    public let onMouseMove = Event<Point2D>()

    /// Occurs when a mouse button is pressed.
    ///
    /// Add a handler for a single button with `onMouseDown(.left) { event in }`.
    public let onMouseDown = Event<MouseEvent>()

    /// Occurs when a mouse button is released.
    ///
    /// Add a handler for a single button with `onMouseUp(.left) { event in }`.
    public let onMouseUp = Event<MouseEvent>()

    /// Occurs when the window is resized, with the new `size`.
    public let onResize = Event<Size2D>()

    /// Occurs when the window's framebuffer is resized, with the new `framebufferSize`.
    public let onFramebufferResize = Event<Size2D>()

    /// Occurs when the window moves, with the new `position`.
    public let onMove = Event<Point2D>()

    /// Occurs when the window's content scale changes, with the new `contentScale`.
    public let onContentScaleChange = Event<Float>()

    /// Occurs when the window starts closing, while its properties can still be read.
    public let onClose = Event<Void>()

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
        glfwSetCursorPosCallback(handle) { handle, x, y in
            MainActor.assumeIsolated { Window.from(handle)?.onMouseMove.trigger(Point2D(Float(x), Float(y))) }
        }
        glfwSetMouseButtonCallback(handle) { handle, button, action, mods in
            MainActor.assumeIsolated { Window.from(handle)?.mouseButtonChanged(button, action: action, mods: mods) }
        }
        glfwSetWindowSizeCallback(handle) { handle, width, height in
            MainActor.assumeIsolated { Window.from(handle)?.onResize.trigger(Size2D(Float(width), Float(height))) }
        }
        glfwSetFramebufferSizeCallback(handle) { handle, width, height in
            MainActor.assumeIsolated {
                Window.from(handle)?.onFramebufferResize.trigger(Size2D(Float(width), Float(height)))
            }
        }
        glfwSetWindowPosCallback(handle) { handle, x, y in
            MainActor.assumeIsolated { Window.from(handle)?.onMove.trigger(Point2D(Float(x), Float(y))) }
        }
        glfwSetWindowContentScaleCallback(handle) { handle, x, _ in
            MainActor.assumeIsolated { Window.from(handle)?.onContentScaleChange.trigger(x) }
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

    /// The size of the window's framebuffer in pixels.
    public var framebufferSize: Size2D {
        guard let handle else { return .zero }
        var width: Int32 = 0
        var height: Int32 = 0
        glfwGetFramebufferSize(handle, &width, &height)
        return Size2D(Float(width), Float(height))
    }

    /// The ratio between the current DPI and the platform's default DPI, e.g. `2` on a Retina display.
    public var contentScale: Float {
        guard let handle else { return 0 }
        var x: Float = 0
        glfwGetWindowContentScale(handle, &x, nil)
        return x
    }

    /// The position of the top-left corner of the window's content area in screen coordinates, relative to the
    /// top-left corner of the primary monitor.
    public var position: Point2D {
        get {
            guard let handle else { return .origin }
            var x: Int32 = 0
            var y: Int32 = 0
            glfwGetWindowPos(handle, &x, &y)
            return Point2D(Float(x), Float(y))
        }
        set {
            guard let handle else { return }
            glfwSetWindowPos(handle, Int32(newValue.x.rounded()), Int32(newValue.y.rounded()))
        }
    }

    /// The position of the mouse cursor in screen coordinates, relative to the top-left corner of the window's
    /// content area.
    ///
    /// The position is still reported when the cursor is outside the content area, so it may be negative or exceed
    /// `size`.
    public var mousePosition: Point2D {
        guard let handle else { return .origin }
        var x: Double = 0
        var y: Double = 0
        glfwGetCursorPos(handle, &x, &y)
        return Point2D(Float(x), Float(y))
    }

    /// Closes the window once the current events have been processed. Has no effect if the window is already
    /// closed.
    ///
    /// When the window closes, `onClose` is triggered, all handlers are removed, and the window is removed from
    /// `App.windows`.
    public func close() {
        guard let handle else { return }
        glfwSetWindowShouldClose(handle, GLFW_TRUE)
    }

    /// Whether the window has been asked to close, either by `close()` or by the user.
    var shouldClose: Bool {
        guard let handle else { return false }
        return glfwWindowShouldClose(handle) == GLFW_TRUE
    }

    /// Triggers `onClose`, removes all handlers, and destroys the native window.
    ///
    /// Must not be called from within a GLFW callback.
    func destroy() {
        guard let handle else { return }
        onClose.trigger()
        removeAllHandlers()
        glfwDestroyWindow(handle)
        self.handle = nil
    }

    private func removeAllHandlers() {
        onMouseMove.removeAll()
        onMouseDown.removeAll()
        onMouseUp.removeAll()
        onResize.removeAll()
        onFramebufferResize.removeAll()
        onMove.removeAll()
        onContentScaleChange.removeAll()
        onClose.removeAll()
    }

    /// Triggers `onMouseDown` or `onMouseUp` for a GLFW mouse button callback.
    private func mouseButtonChanged(_ button: Int32, action: Int32, mods: Int32) {
        let event = MouseEvent(glfwButton: button, action: action, mods: mods, position: mousePosition)
        switch event.action {
        case .down: onMouseDown.trigger(event)
        case .up: onMouseUp.trigger(event)
        }
    }

    /// Returns the window for a GLFW window handle.
    private static func from(_ handle: OpaquePointer?) -> Window? {
        glfwGetWindowUserPointer(handle).map { Unmanaged<Window>.fromOpaque($0).takeUnretainedValue() }
    }
}
