import CGLFW
import Testing
@testable import Creative

@Suite struct InputTests {
    @Test func mouseButtonPresets() {
        #expect(MouseButton.left == MouseButton(rawValue: 0))
        #expect(MouseButton.right == MouseButton(rawValue: 1))
        #expect(MouseButton.middle == MouseButton(rawValue: 2))
        #expect(MouseButton.index(4) == MouseButton(rawValue: 4))
    }

    @Test func mouseButtonDescriptions() {
        #expect(MouseButton.left.description == "left")
        #expect(MouseButton(rawValue: 3).description == "button 4")
        #expect(MouseButton.middle.debugDescription == "MouseButton.middle")
        #expect(MouseButton(rawValue: 3).debugDescription == "MouseButton.index(3)")
    }

    @Test func modifierKeysFromGLFW() {
        #expect(ModifierKeys(glfwMods: 0) == [])
        #expect(ModifierKeys(glfwMods: GLFW_MOD_SHIFT | GLFW_MOD_SUPER) == [.shift, .super])
        #expect(ModifierKeys(glfwMods: GLFW_MOD_CONTROL | GLFW_MOD_ALT) == [.control, .alt])
        #expect(ModifierKeys(glfwMods: GLFW_MOD_CAPS_LOCK | GLFW_MOD_NUM_LOCK) == [])
    }

    @Test func modifierKeysDescriptions() {
        #expect(ModifierKeys().description == "none")
        #expect(ModifierKeys().debugDescription == "ModifierKeys([])")
        #expect(ModifierKeys.command == .super)
        #expect(ModifierKeys.option == .alt)
        #if os(macOS)
        #expect(ModifierKeys([.command, .shift]).description == "shift + command")
        #expect(ModifierKeys([.control, .option]).debugDescription == "ModifierKeys([.control, .option])")
        #else
        #expect(ModifierKeys([.super, .shift]).description == "shift + super")
        #expect(ModifierKeys([.control, .alt]).debugDescription == "ModifierKeys([.control, .alt])")
        #endif
    }

    @Test func mouseEventFromGLFW() {
        let event = MouseEvent(
            glfwButton: GLFW_MOUSE_BUTTON_RIGHT, action: GLFW_PRESS, mods: GLFW_MOD_SHIFT, position: Point2D(1, 2))
        #expect(event == MouseEvent(action: .down, button: .right, modifiers: .shift, position: Point2D(1, 2)))
        #expect(MouseEvent(glfwButton: 4, action: GLFW_RELEASE, mods: 0, position: .origin).action == .up)
    }

    @MainActor @Test func buttonFilteredHandler() {
        let event = Event<MouseEvent>()
        var buttons: [MouseButton] = []
        let handler = event(.left) { buttons.append($0.button) }

        event.trigger(MouseEvent(action: .down, button: .right, position: .origin))
        event.trigger(MouseEvent(action: .down, button: .left, position: .origin))
        #expect(buttons == [.left])

        handler.remove()
        event.trigger(MouseEvent(action: .down, button: .left, position: .origin))
        #expect(buttons == [.left])
    }
}
