import WebGPU

extension TextureFormat {
    /// Returns `true` for sRGB formats.
    var isSrgb: Bool {
        switch self {
        case .rgba8UnormSrgb, .bgra8UnormSrgb: true
        default: false
        }
    }

    /// Returns the format to configure a surface with, preferring an sRGB format so that linear colors display
    /// correctly, or `nil` if `formats` is empty.
    static func preferredSurfaceFormat(from formats: [TextureFormat]) -> TextureFormat? {
        formats.first(where: \.isSrgb) ?? formats.first
    }
}
