import Testing
import WebGPU
@testable import Creative

@Suite struct RenderingTests {
    @Test func webGPUColorFromColor() {
        let color = WebGPU.Color(Color(red: 0.5, green: 0.25, blue: 1, alpha: 0.75))
        #expect(color.r == 0.5)
        #expect(color.g == 0.25)
        #expect(color.b == 1)
        #expect(color.a == 0.75)
    }

    @Test func preferredSurfaceFormatPrefersSRGB() {
        #expect(TextureFormat.preferredSurfaceFormat(from: [.bgra8Unorm, .bgra8UnormSrgb]) == .bgra8UnormSrgb)
    }

    @Test func preferredSurfaceFormatFallsBackToFirst() {
        #expect(TextureFormat.preferredSurfaceFormat(from: [.rgba16Float, .bgra8Unorm]) == .rgba16Float)
        #expect(TextureFormat.preferredSurfaceFormat(from: []) == nil)
    }
}
