import WebGPU

extension WebGPU.Color {
    /// Creates a WebGPU color from a color's linear components.
    init(_ color: Color) {
        self.init(r: Double(color.red), g: Double(color.green), b: Double(color.blue), a: Double(color.alpha))
    }
}
