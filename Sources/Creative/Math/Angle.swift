import RealModule

/// An angle, accessible in radians or degrees.
///
/// The angle is stored and encoded in radians.
/// Angles are not wrapped, so `.degrees(720)` is distinct from `.zero`.
public struct Angle: RawRepresentable, Hashable, Codable, Sendable {
    /// The angle in radians.
    public var rawValue: Float

    /// Creates an angle from a value in radians.
    public init(rawValue: Float) {
        self.rawValue = rawValue
    }

    /// Creates an angle from a value in radians.
    public init(radians: Float) {
        self.init(rawValue: radians)
    }

    /// Creates an angle from a value in degrees.
    public init(degrees: Float) {
        self.init(rawValue: degrees * .pi / 180)
    }

    /// Creates an angle from a value in radians.
    public static func radians(_ radians: Float) -> Angle {
        Angle(radians: radians)
    }

    /// Creates an angle from a value in degrees.
    public static func degrees(_ degrees: Float) -> Angle {
        Angle(degrees: degrees)
    }

    /// The angle in radians.
    public var radians: Float {
        get { rawValue }
        set { rawValue = newValue }
    }

    /// The angle in degrees.
    public var degrees: Float {
        get { rawValue * 180 / .pi }
        set { rawValue = newValue * .pi / 180 }
    }
}

extension Angle {
    /// A quarter turn (90°).
    public static let quarterTurn = Angle(radians: .pi / 2)

    /// A half turn (180°).
    public static let halfTurn = Angle(radians: .pi)

    /// A full turn (360°).
    public static let fullTurn = Angle(radians: 2 * .pi)
}

/// The sine of `angle`.
public func sin(_ angle: Angle) -> Float {
    .sin(angle.rawValue)
}

/// The cosine of `angle`.
public func cos(_ angle: Angle) -> Float {
    .cos(angle.rawValue)
}

/// The tangent of `angle`.
public func tan(_ angle: Angle) -> Float {
    .tan(angle.rawValue)
}

extension Angle: AdditiveArithmetic {
    /// An angle of zero.
    public static let zero = Angle(rawValue: 0)

    public static func + (lhs: Angle, rhs: Angle) -> Angle {
        Angle(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func - (lhs: Angle, rhs: Angle) -> Angle {
        Angle(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func += (lhs: inout Angle, rhs: Angle) {
        lhs.rawValue += rhs.rawValue
    }

    public static func -= (lhs: inout Angle, rhs: Angle) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Angle {
    /// Negates the angle.
    public static prefix func - (angle: Angle) -> Angle {
        Angle(rawValue: -angle.rawValue)
    }

    /// Multiplies the angle by a scalar.
    public static func * (lhs: Angle, rhs: Float) -> Angle {
        Angle(rawValue: lhs.rawValue * rhs)
    }

    /// Multiplies the angle by a scalar.
    public static func * (lhs: Float, rhs: Angle) -> Angle {
        Angle(rawValue: lhs * rhs.rawValue)
    }

    /// Divides the angle by a scalar.
    public static func / (lhs: Angle, rhs: Float) -> Angle {
        Angle(rawValue: lhs.rawValue / rhs)
    }

    public static func *= (lhs: inout Angle, rhs: Float) {
        lhs.rawValue *= rhs
    }

    public static func /= (lhs: inout Angle, rhs: Float) {
        lhs.rawValue /= rhs
    }
}

extension Angle: Comparable {
    public static func < (lhs: Angle, rhs: Angle) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension Angle: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description in degrees, e.g. `90°`.
    public var description: String {
        "\(degrees.displayDescription)°"
    }

    /// A description that constructs the same angle as Swift code, e.g. `Angle(radians: 1.5707963)`.
    public var debugDescription: String {
        "Angle(radians: \(radians))"
    }
}
