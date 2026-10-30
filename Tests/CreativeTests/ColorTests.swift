import Foundation
import RealModule
import Testing
@testable import Creative

@Suite struct ColorTests {
    let a = Color(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
    let b = Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

    @Test func components() {
        #expect(a.red == 0.1)
        #expect(a.green == 0.2)
        #expect(a.blue == 0.3)
        #expect(a.alpha == 0.4)
        #expect(a.rgb == SIMD3(0.1, 0.2, 0.3))
        #expect(a.rgba == SIMD4(0.1, 0.2, 0.3, 0.4))
        #expect(a.rawValue == a.rgba)
    }

    @Test func settingComponents() {
        var color = Color.clear
        color.red = 0.1
        color.green = 0.2
        color.blue = 0.3
        color.alpha = 0.4
        #expect(color == a)
        color.rgb = SIMD3(1, 1, 1)
        #expect(color == Color(white: 1, alpha: 0.4))
        color.rgba = .one
        #expect(color == .white)
    }

    @Test func scalingRGB() {
        var color = Color(white: 0.5)
        color.rgb *= 0.5
        #expect(color == Color(white: 0.25))
    }

    @Test func initializers() {
        #expect(Color(red: 1, green: 1, blue: 1) == .white)
        #expect(Color(rgb: SIMD3(0.1, 0.2, 0.3), alpha: 0.4) == a)
        #expect(Color(rgb: SIMD3(1, 1, 1)) == .white)
        #expect(Color(rgba: SIMD4(0.1, 0.2, 0.3, 0.4)) == a)
        #expect(Color(white: 0.5, alpha: 0.5) == b)
        #expect(Color(SIMD4(0.1, 0.2, 0.3, 0.4)) == a)
    }

    @Test func srgb() {
        // #808080 is the familiar CSS gray.
        let gray = Color(srgbRed: 128 / 255, green: 128 / 255, blue: 128 / 255, alpha: 0.5)
        #expect(gray.red.isApproximatelyEqual(to: 0.21586))
        #expect(gray.alpha == 0.5)
        #expect(Color(srgbRed: 0, green: 1, blue: 0.02) == Color(red: 0, green: 1, blue: 0.02 / 12.92))
    }

    @Test func presets() {
        #expect(Color.clear == Color(red: 0, green: 0, blue: 0, alpha: 0))
        #expect(Color.black == Color(red: 0, green: 0, blue: 0))
        #expect(Color.red == Color(red: 1, green: 0, blue: 0))
        #expect(Color.cyan == Color(red: 0, green: 1, blue: 1))
        #expect(Color.orange == Color(srgbRed: 1, green: 0.5, blue: 0))
        #expect(Color.orange.green.isApproximatelyEqual(to: 0.21404))
    }

    @Test func addition() {
        #expect(isApproximatelyEqual(a + b, Color(red: 0.6, green: 0.7, blue: 0.8, alpha: 0.9)))
    }

    @Test func subtraction() {
        #expect(isApproximatelyEqual(b - a, Color(red: 0.4, green: 0.3, blue: 0.2, alpha: 0.1)))
    }

    @Test func tinting() {
        #expect(isApproximatelyEqual(a * b, Color(red: 0.05, green: 0.1, blue: 0.15, alpha: 0.2)))
        #expect(Color.yellow * .cyan == .green)
    }

    @Test func compoundAssignment() {
        var color = a
        color += b
        color -= b
        #expect(isApproximatelyEqual(color, a))
        color *= .white
        #expect(isApproximatelyEqual(color, a))
    }

    @Test func description() {
        #expect(Color(red: 1, green: 0.5, blue: 0).description == "rgba(1, 0.5, 0, 1)")
    }

    @Test func debugDescription() {
        #expect(Color(red: 1, green: 0.5, blue: 0).debugDescription == "Color(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)")
    }

    @Test func codable() throws {
        let color = Color(red: 1, green: 0.5, blue: 0, alpha: 1)
        let data = try JSONEncoder().encode(color)
        #expect(String(decoding: data, as: UTF8.self) == "[1,0.5,0,1]")
        #expect(try JSONDecoder().decode(Color.self, from: data) == color)
    }
}
