// Generated from Size.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.

/// An extent in 2D space.
public struct Size2D: SIMDRepresentable {
    /// The underlying SIMD value.
    public var rawValue: SIMD2<Float>

    /// Creates a size from a SIMD value.
    public init(rawValue: SIMD2<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a size with the given components.
    public init(_ width: Float, _ height: Float) {
        self.init(rawValue: SIMD2<Float>(width, height))
    }

    /// Creates a size with the given components.
    public init(width: Float, height: Float) {
        self.init(rawValue: SIMD2<Float>(width, height))
    }

    /// Creates a size with the components of `vector`.
    public init(_ vector: Vector2D) {
        self.init(rawValue: vector.rawValue)
    }

    /// Creates a size with the components of `point`.
    public init(_ point: Point2D) {
        self.init(rawValue: point.rawValue)
    }

    /// The width component.
    public var width: Float {
        get { rawValue.x }
        set { rawValue.x = newValue }
    }

    /// The height component.
    public var height: Float {
        get { rawValue.y }
        set { rawValue.y = newValue }
    }
}

extension Size2D {
    /// A size with all components set to one.
    public static let one = Size2D(rawValue: .one)
}

extension Size2D: AdditiveArithmetic {
    /// A size with all components set to zero.
    public static let zero = Size2D(rawValue: .zero)

    public static func + (lhs: Size2D, rhs: Size2D) -> Size2D {
        Size2D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func - (lhs: Size2D, rhs: Size2D) -> Size2D {
        Size2D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func += (lhs: inout Size2D, rhs: Size2D) {
        lhs.rawValue += rhs.rawValue
    }

    public static func -= (lhs: inout Size2D, rhs: Size2D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Size2D {
    /// Multiplies each component by a scalar.
    public static func * (lhs: Size2D, rhs: Float) -> Size2D {
        Size2D(rawValue: lhs.rawValue * rhs)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Float, rhs: Size2D) -> Size2D {
        Size2D(rawValue: lhs * rhs.rawValue)
    }

    /// Divides each component by a scalar.
    public static func / (lhs: Size2D, rhs: Float) -> Size2D {
        Size2D(rawValue: lhs.rawValue / rhs)
    }

    /// Multiplies corresponding components.
    public static func * (lhs: Size2D, rhs: Size2D) -> Size2D {
        Size2D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    /// Divides corresponding components.
    public static func / (lhs: Size2D, rhs: Size2D) -> Size2D {
        Size2D(rawValue: lhs.rawValue / rhs.rawValue)
    }

    public static func *= (lhs: inout Size2D, rhs: Float) {
        lhs.rawValue *= rhs
    }

    public static func /= (lhs: inout Size2D, rhs: Float) {
        lhs.rawValue /= rhs
    }

    public static func *= (lhs: inout Size2D, rhs: Size2D) {
        lhs.rawValue *= rhs.rawValue
    }

    public static func /= (lhs: inout Size2D, rhs: Size2D) {
        lhs.rawValue /= rhs.rawValue
    }
}

extension Size2D {
    /// Grows a size by the components of a vector.
    public static func + (lhs: Size2D, rhs: Vector2D) -> Size2D {
        Size2D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    /// Shrinks a size by the components of a vector.
    public static func - (lhs: Size2D, rhs: Vector2D) -> Size2D {
        Size2D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Grows a size by the components of a vector.
    public static func += (lhs: inout Size2D, rhs: Vector2D) {
        lhs.rawValue += rhs.rawValue
    }

    /// Shrinks a size by the components of a vector.
    public static func -= (lhs: inout Size2D, rhs: Vector2D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Size2D: CustomStringConvertible {
    public var description: String {
        "Size2D(width: \(width), height: \(height))"
    }
}

extension Vector2D {
    /// Creates a vector with the components of `size`.
    public init(_ size: Size2D) {
        self.init(rawValue: size.rawValue)
    }
}

/// An extent in 3D space.
public struct Size3D: SIMDRepresentable {
    /// The underlying SIMD value.
    public var rawValue: SIMD3<Float>

    /// Creates a size from a SIMD value.
    public init(rawValue: SIMD3<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a size with the given components.
    public init(_ width: Float, _ height: Float, _ depth: Float) {
        self.init(rawValue: SIMD3<Float>(width, height, depth))
    }

    /// Creates a size with the given components.
    public init(width: Float, height: Float, depth: Float) {
        self.init(rawValue: SIMD3<Float>(width, height, depth))
    }

    /// Creates a size with the components of `vector`.
    public init(_ vector: Vector3D) {
        self.init(rawValue: vector.rawValue)
    }

    /// Creates a size with the components of `point`.
    public init(_ point: Point3D) {
        self.init(rawValue: point.rawValue)
    }

    /// The width component.
    public var width: Float {
        get { rawValue.x }
        set { rawValue.x = newValue }
    }

    /// The height component.
    public var height: Float {
        get { rawValue.y }
        set { rawValue.y = newValue }
    }

    /// The depth component.
    public var depth: Float {
        get { rawValue.z }
        set { rawValue.z = newValue }
    }
}

extension Size3D {
    /// A size with all components set to one.
    public static let one = Size3D(rawValue: .one)
}

extension Size3D: AdditiveArithmetic {
    /// A size with all components set to zero.
    public static let zero = Size3D(rawValue: .zero)

    public static func + (lhs: Size3D, rhs: Size3D) -> Size3D {
        Size3D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func - (lhs: Size3D, rhs: Size3D) -> Size3D {
        Size3D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func += (lhs: inout Size3D, rhs: Size3D) {
        lhs.rawValue += rhs.rawValue
    }

    public static func -= (lhs: inout Size3D, rhs: Size3D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Size3D {
    /// Multiplies each component by a scalar.
    public static func * (lhs: Size3D, rhs: Float) -> Size3D {
        Size3D(rawValue: lhs.rawValue * rhs)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Float, rhs: Size3D) -> Size3D {
        Size3D(rawValue: lhs * rhs.rawValue)
    }

    /// Divides each component by a scalar.
    public static func / (lhs: Size3D, rhs: Float) -> Size3D {
        Size3D(rawValue: lhs.rawValue / rhs)
    }

    /// Multiplies corresponding components.
    public static func * (lhs: Size3D, rhs: Size3D) -> Size3D {
        Size3D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    /// Divides corresponding components.
    public static func / (lhs: Size3D, rhs: Size3D) -> Size3D {
        Size3D(rawValue: lhs.rawValue / rhs.rawValue)
    }

    public static func *= (lhs: inout Size3D, rhs: Float) {
        lhs.rawValue *= rhs
    }

    public static func /= (lhs: inout Size3D, rhs: Float) {
        lhs.rawValue /= rhs
    }

    public static func *= (lhs: inout Size3D, rhs: Size3D) {
        lhs.rawValue *= rhs.rawValue
    }

    public static func /= (lhs: inout Size3D, rhs: Size3D) {
        lhs.rawValue /= rhs.rawValue
    }
}

extension Size3D {
    /// Grows a size by the components of a vector.
    public static func + (lhs: Size3D, rhs: Vector3D) -> Size3D {
        Size3D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    /// Shrinks a size by the components of a vector.
    public static func - (lhs: Size3D, rhs: Vector3D) -> Size3D {
        Size3D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Grows a size by the components of a vector.
    public static func += (lhs: inout Size3D, rhs: Vector3D) {
        lhs.rawValue += rhs.rawValue
    }

    /// Shrinks a size by the components of a vector.
    public static func -= (lhs: inout Size3D, rhs: Vector3D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Size3D: CustomStringConvertible {
    public var description: String {
        "Size3D(width: \(width), height: \(height), depth: \(depth))"
    }
}

extension Vector3D {
    /// Creates a vector with the components of `size`.
    public init(_ size: Size3D) {
        self.init(rawValue: size.rawValue)
    }
}
