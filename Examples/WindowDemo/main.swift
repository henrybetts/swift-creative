import Creative

App.run {
    let window = Window(title: "First", size: Size2D(640, 480))
    window.title = "First (\(window.size))"
    _ = Window(title: "Second", size: Size2D(320, 240))
}
print("All windows closed")
