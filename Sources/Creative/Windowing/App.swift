import CGLFW

/// The process-wide application runtime, which owns the windowing system and keeps open windows alive.
@MainActor
public enum App {
    /// The open windows, in the order they were opened.
    public private(set) static var windows: [Window] = []

    /// Whether `run(_:)` is currently executing.
    public private(set) static var isRunning = false

    /// The most recent error reported by GLFW.
    private(set) static var lastGLFWError = "unknown error"

    /// Initializes the windowing system, calls `setup`, then processes events until all windows are closed.
    ///
    /// Open windows in `setup`. If none are open when it returns, this method returns immediately.
    public static func run(_ setup: () -> Void) {
        precondition(!isRunning, "App.run(_:) is already running")
        isRunning = true
        defer { isRunning = false }

        glfwSetErrorCallback { _, description in
            let message = description.map { String(cString: $0) } ?? "unknown error"
            MainActor.assumeIsolated { App.lastGLFWError = message }
        }
        guard glfwInit() == GLFW_TRUE else {
            fatalError("Failed to initialize GLFW: \(lastGLFWError)")
        }
        defer { glfwTerminate() }

        do {
            try Device.withDefault {
                setup()
                destroyClosedWindows()
                while !windows.isEmpty {
                    glfwWaitEvents()
                    destroyClosedWindows()
                }
            }
        } catch {
            fatalError("\(error)")
        }
    }

    /// Closes all open windows, which ends `run(_:)`.
    public static func quit() {
        for window in windows {
            window.close()
        }
    }

    static func addWindow(_ window: Window) {
        windows.append(window)
    }

    /// Destroys and removes windows that have been asked to close.
    private static func destroyClosedWindows() {
        while let index = windows.firstIndex(where: \.shouldClose) {
            windows.remove(at: index).destroy()
        }
    }
}
