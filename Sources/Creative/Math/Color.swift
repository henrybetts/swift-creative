import RealModule

/// An RGBA color with linear sRGB components and straight (non-premultiplied) alpha.
///
/// Components are not clamped, so values above one can represent HDR colors.
public struct Color: SIMDRepresentable {
    /// The red, green, blue and alpha components.
    public var rawValue: SIMD4<Float>

    /// Creates a color from linear red, green, blue and alpha components.
    public init(rawValue: SIMD4<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a color from linear components.
    public init(red: Float, green: Float, blue: Float, alpha: Float = 1) {
        self.init(rawValue: SIMD4(red, green, blue, alpha))
    }

    /// Creates a color from linear red, green and blue components.
    public init(rgb: SIMD3<Float>, alpha: Float = 1) {
        self.init(rawValue: SIMD4(rgb, alpha))
    }

    /// Creates a color from linear red, green, blue and alpha components.
    public init(rgba: SIMD4<Float>) {
        self.init(rawValue: rgba)
    }

    /// Creates a gray color with all linear color components set to `white`.
    public init(white: Float, alpha: Float = 1) {
        self.init(rgb: SIMD3(repeating: white), alpha: alpha)
    }

    /// Creates a color from sRGB-encoded components.
    ///
    /// The color components are converted to linear; `alpha` is used as is.
    public init(srgbRed red: Float, green: Float, blue: Float, alpha: Float = 1) {
        self.init(
            red: Self.linear(fromSRGB: red),
            green: Self.linear(fromSRGB: green),
            blue: Self.linear(fromSRGB: blue),
            alpha: alpha
        )
    }

    /// Decodes an sRGB-encoded component to linear using the sRGB transfer function.
    private static func linear(fromSRGB value: Float) -> Float {
        value <= 0.04045 ? value / 12.92 : .pow((value + 0.055) / 1.055, 2.4)
    }

    /// The red component.
    public var red: Float {
        get { rawValue.x }
        set { rawValue.x = newValue }
    }

    /// The green component.
    public var green: Float {
        get { rawValue.y }
        set { rawValue.y = newValue }
    }

    /// The blue component.
    public var blue: Float {
        get { rawValue.z }
        set { rawValue.z = newValue }
    }

    /// The alpha component.
    public var alpha: Float {
        get { rawValue.w }
        set { rawValue.w = newValue }
    }

    /// The red, green and blue components.
    public var rgb: SIMD3<Float> {
        get { SIMD3(rawValue.x, rawValue.y, rawValue.z) }
        set { rawValue = SIMD4(newValue, rawValue.w) }
    }

    /// The red, green, blue and alpha components.
    public var rgba: SIMD4<Float> {
        get { rawValue }
        set { rawValue = newValue }
    }
}

extension Color {
    /// Transparent black.
    public static let clear = Color(rawValue: .zero)

    /// Black.
    public static let black = Color(white: 0)

    /// White.
    public static let white = Color(white: 1)

    // Primary colors.

    /// Red, an RGB primary.
    public static let red = Color(red: 1, green: 0, blue: 0)

    /// Green, an RGB primary. Unlike CSS `green`, this is full intensity.
    public static let green = Color(red: 0, green: 1, blue: 0)

    /// Blue, an RGB primary.
    public static let blue = Color(red: 0, green: 0, blue: 1)

    // Secondary colors, mixing two primaries equally.

    /// Cyan, an RGB secondary of green and blue.
    public static let cyan = Color(red: 0, green: 1, blue: 1)

    /// Magenta, an RGB secondary of red and blue.
    public static let magenta = Color(red: 1, green: 0, blue: 1)

    /// Yellow, an RGB secondary of red and green.
    public static let yellow = Color(red: 1, green: 1, blue: 0)

    // Tertiary colors, completing the 12-hue RGB color wheel. Defined with sRGB-encoded
    // half intensity to match color pickers and CSS, e.g. orange is `#FF8000`.

    /// Orange, a tertiary between red and yellow.
    public static let orange = Color(srgbRed: 1, green: 0.5, blue: 0)

    /// Chartreuse, a tertiary between yellow and green.
    public static let chartreuse = Color(srgbRed: 0.5, green: 1, blue: 0)

    /// Spring green, a tertiary between green and cyan.
    public static let springGreen = Color(srgbRed: 0, green: 1, blue: 0.5)

    /// Azure, a tertiary between cyan and blue.
    public static let azure = Color(srgbRed: 0, green: 0.5, blue: 1)

    /// Violet, a tertiary between blue and magenta.
    public static let violet = Color(srgbRed: 0.5, green: 0, blue: 1)

    /// Rose, a tertiary between magenta and red.
    public static let rose = Color(srgbRed: 1, green: 0, blue: 0.5)
}

extension Color: AdditiveArithmetic {
    /// A color with all components set to zero, equal to `.clear`.
    public static let zero = Color(rawValue: .zero)

    public static func + (lhs: Color, rhs: Color) -> Color {
        Color(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func - (lhs: Color, rhs: Color) -> Color {
        Color(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func += (lhs: inout Color, rhs: Color) {
        lhs.rawValue += rhs.rawValue
    }

    public static func -= (lhs: inout Color, rhs: Color) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Color {
    /// Multiplies corresponding components, including alpha, to tint one color by another.
    public static func * (lhs: Color, rhs: Color) -> Color {
        Color(rawValue: lhs.rawValue * rhs.rawValue)
    }

    public static func *= (lhs: inout Color, rhs: Color) {
        lhs.rawValue *= rhs.rawValue
    }
}

extension Color: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description of the linear components, e.g. `rgba(1, 0.5, 0, 1)`.
    public var description: String {
        "rgba(\(red.displayDescription), \(green.displayDescription), \(blue.displayDescription), \(alpha.displayDescription))"
    }

    /// A description that constructs the same color as Swift code, e.g. `Color(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)`.
    public var debugDescription: String {
        "Color(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha))"
    }
}
