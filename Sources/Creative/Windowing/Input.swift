import CGLFW

/// A button on a mouse, identified by its zero-based index, e.g. `0` for the left button.
public struct MouseButton: RawRepresentable, Hashable, Sendable {
    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// The button with the given zero-based index.
    public static func index(_ index: Int) -> MouseButton {
        MouseButton(rawValue: index)
    }

    /// The left, or primary, button.
    public static let left = MouseButton(rawValue: 0)

    /// The right, or secondary, button.
    public static let right = MouseButton(rawValue: 1)

    /// The middle button, which is often the scroll wheel.
    public static let middle = MouseButton(rawValue: 2)
}

extension MouseButton: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description, e.g. `left` or `button 4`.
    public var description: String {
        switch self {
        case .left: "left"
        case .right: "right"
        case .middle: "middle"
        default: "button \(rawValue + 1)"
        }
    }

    /// A description that constructs the same button as Swift code, e.g. `MouseButton.left` or
    /// `MouseButton.index(3)`.
    public var debugDescription: String {
        switch self {
        case .left: "MouseButton.left"
        case .right: "MouseButton.right"
        case .middle: "MouseButton.middle"
        default: "MouseButton.index(\(rawValue))"
        }
    }
}

/// The modifier keys held during an input event.
public struct ModifierKeys: OptionSet, Hashable, Sendable {
    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// The Shift key.
    public static let shift = ModifierKeys(rawValue: 1 << 0)

    /// The Control key.
    public static let control = ModifierKeys(rawValue: 1 << 1)

    /// The Alt key, or Option on macOS.
    public static let alt = ModifierKeys(rawValue: 1 << 2)

    /// The Super or Windows key, or Command on macOS.
    public static let `super` = ModifierKeys(rawValue: 1 << 3)

    /// The Command key on macOS, an alias for `super`.
    public static let command = ModifierKeys.super

    /// The Option key on macOS, an alias for `alt`.
    public static let option = ModifierKeys.alt

    /// Creates modifier keys from GLFW's modifier bits, ignoring lock keys.
    init(glfwMods mods: Int32) {
        self = []
        if mods & GLFW_MOD_SHIFT != 0 { insert(.shift) }
        if mods & GLFW_MOD_CONTROL != 0 { insert(.control) }
        if mods & GLFW_MOD_ALT != 0 { insert(.alt) }
        if mods & GLFW_MOD_SUPER != 0 { insert(.super) }
    }

    /// The name of each key, using the platform's names for `alt` and `super`.
    private static let names: [(key: ModifierKeys, name: String)] = {
        #if os(macOS)
        [(.shift, "shift"), (.control, "control"), (.option, "option"), (.command, "command")]
        #else
        [(.shift, "shift"), (.control, "control"), (.alt, "alt"), (.super, "super")]
        #endif
    }()
}

extension ModifierKeys: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description using the platform's key names, e.g. `shift + command` on macOS, or `none` if
    /// empty.
    public var description: String {
        let names = Self.names.filter { contains($0.key) }.map(\.name)
        return names.isEmpty ? "none" : names.joined(separator: " + ")
    }

    /// A description that constructs the same keys as Swift code using the platform's key names, e.g.
    /// `ModifierKeys([.shift, .command])` on macOS.
    public var debugDescription: String {
        let names = Self.names.filter { contains($0.key) }.map { ".\($0.name)" }
        return "ModifierKeys([\(names.joined(separator: ", "))])"
    }
}

/// A mouse button being pressed or released.
public struct MouseEvent: Equatable, Sendable {
    /// Whether a mouse button went down or up.
    public enum Action: Hashable, Sendable {
        /// The button was pressed.
        case down

        /// The button was released.
        case up
    }

    /// Whether the button went down or up.
    public var action: Action

    /// The button that went down or up.
    public var button: MouseButton

    /// The modifier keys held at the time of the event.
    public var modifiers: ModifierKeys

    /// The position of the mouse cursor in screen coordinates, relative to the top-left corner of the window's
    /// content area.
    public var position: Point2D

    /// Creates a mouse event.
    public init(action: Action, button: MouseButton, modifiers: ModifierKeys = [], position: Point2D) {
        self.action = action
        self.button = button
        self.modifiers = modifiers
        self.position = position
    }

    /// Creates a mouse event from the values passed to a GLFW mouse button callback.
    init(glfwButton button: Int32, action: Int32, mods: Int32, position: Point2D) {
        self.init(
            action: action == GLFW_PRESS ? .down : .up,
            button: MouseButton(rawValue: Int(button)),
            modifiers: ModifierKeys(glfwMods: mods),
            position: position)
    }
}

extension Event where Value == MouseEvent {
    /// Adds a handler that is called each time the event occurs for `button`.
    @discardableResult
    public func callAsFunction(_ button: MouseButton, _ call: @escaping (MouseEvent) -> Void) -> EventHandler {
        addHandler(button, call)
    }

    /// Adds a handler that is called each time the event occurs for `button`.
    @discardableResult
    public func addHandler(_ button: MouseButton, _ call: @escaping (MouseEvent) -> Void) -> EventHandler {
        addHandler { event in
            if event.button == button {
                call(event)
            }
        }
    }
}
