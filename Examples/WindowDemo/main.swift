import Creative

App.run {
    let window = Window(title: "First", size: Size2D(640, 480))
    window.title = "First (\(window.size))"

    window.onResize { newSize in
        window.title = "First (\(newSize))"
    }

    window.onClose {
        print("Closing first window")
    }

    let second = Window(title: "Second", size: Size2D(320, 240))
    
    second.onClose {
        print("Closing second window")
    }
}
print("All windows closed")
