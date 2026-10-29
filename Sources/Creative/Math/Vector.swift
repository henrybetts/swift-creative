// Generated from Vector.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.

/// A 2D vector.
public struct Vector2D: SIMDRepresentable {
    /// The underlying SIMD value.
    public var rawValue: SIMD2<Float>

    /// Creates a vector from a SIMD value.
    public init(rawValue: SIMD2<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a vector with the given components.
    public init(_ x: Float, _ y: Float) {
        self.init(rawValue: SIMD2<Float>(x, y))
    }

    /// Creates a vector with the given components.
    public init(x: Float, y: Float) {
        self.init(rawValue: SIMD2<Float>(x, y))
    }

    /// The x component.
    public var x: Float {
        get { rawValue.x }
        set { rawValue.x = newValue }
    }

    /// The y component.
    public var y: Float {
        get { rawValue.y }
        set { rawValue.y = newValue }
    }
}

extension Vector2D {
    /// A vector with all components set to one.
    public static let one = Vector2D(rawValue: .one)

    /// The squared length of the vector. Cheaper than `length` when only comparing lengths.
    public var lengthSquared: Float {
        dot(self)
    }

    /// The length (magnitude) of the vector.
    public var length: Float {
        lengthSquared.squareRoot()
    }

    /// The vector scaled to a length of one, or `.zero` if the vector has zero length.
    public var normalized: Vector2D {
        let length = length
        return length > 0 ? self / length : .zero
    }

    /// Scales the vector to a length of one, or sets it to `.zero` if it has zero length.
    public mutating func normalize() {
        self = normalized
    }

    /// The dot product of this vector and `other`.
    public func dot(_ other: Vector2D) -> Float {
        (rawValue * other.rawValue).sum()
    }
}

extension Vector2D: AdditiveArithmetic {
    /// A vector with all components set to zero.
    public static let zero = Vector2D(rawValue: .zero)

    public static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        Vector2D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func - (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        Vector2D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func += (lhs: inout Vector2D, rhs: Vector2D) {
        lhs.rawValue += rhs.rawValue
    }

    public static func -= (lhs: inout Vector2D, rhs: Vector2D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Vector2D {
    /// Negates each component.
    public static prefix func - (vector: Vector2D) -> Vector2D {
        Vector2D(rawValue: -vector.rawValue)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Vector2D, rhs: Float) -> Vector2D {
        Vector2D(rawValue: lhs.rawValue * rhs)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Float, rhs: Vector2D) -> Vector2D {
        Vector2D(rawValue: lhs * rhs.rawValue)
    }

    /// Divides each component by a scalar.
    public static func / (lhs: Vector2D, rhs: Float) -> Vector2D {
        Vector2D(rawValue: lhs.rawValue / rhs)
    }

    /// Multiplies corresponding components.
    public static func * (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        Vector2D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    /// Divides corresponding components.
    public static func / (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        Vector2D(rawValue: lhs.rawValue / rhs.rawValue)
    }

    public static func *= (lhs: inout Vector2D, rhs: Float) {
        lhs.rawValue *= rhs
    }

    public static func /= (lhs: inout Vector2D, rhs: Float) {
        lhs.rawValue /= rhs
    }

    public static func *= (lhs: inout Vector2D, rhs: Vector2D) {
        lhs.rawValue *= rhs.rawValue
    }

    public static func /= (lhs: inout Vector2D, rhs: Vector2D) {
        lhs.rawValue /= rhs.rawValue
    }
}

extension Vector2D: CustomStringConvertible {
    public var description: String {
        "Vector2D(x: \(x), y: \(y))"
    }
}

/// A 3D vector.
public struct Vector3D: SIMDRepresentable {
    /// The underlying SIMD value.
    public var rawValue: SIMD3<Float>

    /// Creates a vector from a SIMD value.
    public init(rawValue: SIMD3<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a vector with the given components.
    public init(_ x: Float, _ y: Float, _ z: Float) {
        self.init(rawValue: SIMD3<Float>(x, y, z))
    }

    /// Creates a vector with the given components.
    public init(x: Float, y: Float, z: Float) {
        self.init(rawValue: SIMD3<Float>(x, y, z))
    }

    /// The x component.
    public var x: Float {
        get { rawValue.x }
        set { rawValue.x = newValue }
    }

    /// The y component.
    public var y: Float {
        get { rawValue.y }
        set { rawValue.y = newValue }
    }

    /// The z component.
    public var z: Float {
        get { rawValue.z }
        set { rawValue.z = newValue }
    }
}

extension Vector3D {
    /// A vector with all components set to one.
    public static let one = Vector3D(rawValue: .one)

    /// The squared length of the vector. Cheaper than `length` when only comparing lengths.
    public var lengthSquared: Float {
        dot(self)
    }

    /// The length (magnitude) of the vector.
    public var length: Float {
        lengthSquared.squareRoot()
    }

    /// The vector scaled to a length of one, or `.zero` if the vector has zero length.
    public var normalized: Vector3D {
        let length = length
        return length > 0 ? self / length : .zero
    }

    /// Scales the vector to a length of one, or sets it to `.zero` if it has zero length.
    public mutating func normalize() {
        self = normalized
    }

    /// The dot product of this vector and `other`.
    public func dot(_ other: Vector3D) -> Float {
        (rawValue * other.rawValue).sum()
    }

    /// The cross product of this vector and `other`.
    public func cross(_ other: Vector3D) -> Vector3D {
        Vector3D(
            y * other.z - z * other.y,
            z * other.x - x * other.z,
            x * other.y - y * other.x
        )
    }
}

extension Vector3D: AdditiveArithmetic {
    /// A vector with all components set to zero.
    public static let zero = Vector3D(rawValue: .zero)

    public static func + (lhs: Vector3D, rhs: Vector3D) -> Vector3D {
        Vector3D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func - (lhs: Vector3D, rhs: Vector3D) -> Vector3D {
        Vector3D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func += (lhs: inout Vector3D, rhs: Vector3D) {
        lhs.rawValue += rhs.rawValue
    }

    public static func -= (lhs: inout Vector3D, rhs: Vector3D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Vector3D {
    /// Negates each component.
    public static prefix func - (vector: Vector3D) -> Vector3D {
        Vector3D(rawValue: -vector.rawValue)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Vector3D, rhs: Float) -> Vector3D {
        Vector3D(rawValue: lhs.rawValue * rhs)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Float, rhs: Vector3D) -> Vector3D {
        Vector3D(rawValue: lhs * rhs.rawValue)
    }

    /// Divides each component by a scalar.
    public static func / (lhs: Vector3D, rhs: Float) -> Vector3D {
        Vector3D(rawValue: lhs.rawValue / rhs)
    }

    /// Multiplies corresponding components.
    public static func * (lhs: Vector3D, rhs: Vector3D) -> Vector3D {
        Vector3D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    /// Divides corresponding components.
    public static func / (lhs: Vector3D, rhs: Vector3D) -> Vector3D {
        Vector3D(rawValue: lhs.rawValue / rhs.rawValue)
    }

    public static func *= (lhs: inout Vector3D, rhs: Float) {
        lhs.rawValue *= rhs
    }

    public static func /= (lhs: inout Vector3D, rhs: Float) {
        lhs.rawValue /= rhs
    }

    public static func *= (lhs: inout Vector3D, rhs: Vector3D) {
        lhs.rawValue *= rhs.rawValue
    }

    public static func /= (lhs: inout Vector3D, rhs: Vector3D) {
        lhs.rawValue /= rhs.rawValue
    }
}

extension Vector3D: CustomStringConvertible {
    public var description: String {
        "Vector3D(x: \(x), y: \(y), z: \(z))"
    }
}

/// A 4D vector.
public struct Vector4D: SIMDRepresentable {
    /// The underlying SIMD value.
    public var rawValue: SIMD4<Float>

    /// Creates a vector from a SIMD value.
    public init(rawValue: SIMD4<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a vector with the given components.
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.init(rawValue: SIMD4<Float>(x, y, z, w))
    }

    /// Creates a vector with the given components.
    public init(x: Float, y: Float, z: Float, w: Float) {
        self.init(rawValue: SIMD4<Float>(x, y, z, w))
    }

    /// The x component.
    public var x: Float {
        get { rawValue.x }
        set { rawValue.x = newValue }
    }

    /// The y component.
    public var y: Float {
        get { rawValue.y }
        set { rawValue.y = newValue }
    }

    /// The z component.
    public var z: Float {
        get { rawValue.z }
        set { rawValue.z = newValue }
    }

    /// The w component.
    public var w: Float {
        get { rawValue.w }
        set { rawValue.w = newValue }
    }
}

extension Vector4D {
    /// A vector with all components set to one.
    public static let one = Vector4D(rawValue: .one)

    /// The squared length of the vector. Cheaper than `length` when only comparing lengths.
    public var lengthSquared: Float {
        dot(self)
    }

    /// The length (magnitude) of the vector.
    public var length: Float {
        lengthSquared.squareRoot()
    }

    /// The vector scaled to a length of one, or `.zero` if the vector has zero length.
    public var normalized: Vector4D {
        let length = length
        return length > 0 ? self / length : .zero
    }

    /// Scales the vector to a length of one, or sets it to `.zero` if it has zero length.
    public mutating func normalize() {
        self = normalized
    }

    /// The dot product of this vector and `other`.
    public func dot(_ other: Vector4D) -> Float {
        (rawValue * other.rawValue).sum()
    }
}

extension Vector4D: AdditiveArithmetic {
    /// A vector with all components set to zero.
    public static let zero = Vector4D(rawValue: .zero)

    public static func + (lhs: Vector4D, rhs: Vector4D) -> Vector4D {
        Vector4D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func - (lhs: Vector4D, rhs: Vector4D) -> Vector4D {
        Vector4D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func += (lhs: inout Vector4D, rhs: Vector4D) {
        lhs.rawValue += rhs.rawValue
    }

    public static func -= (lhs: inout Vector4D, rhs: Vector4D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Vector4D {
    /// Negates each component.
    public static prefix func - (vector: Vector4D) -> Vector4D {
        Vector4D(rawValue: -vector.rawValue)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Vector4D, rhs: Float) -> Vector4D {
        Vector4D(rawValue: lhs.rawValue * rhs)
    }

    /// Multiplies each component by a scalar.
    public static func * (lhs: Float, rhs: Vector4D) -> Vector4D {
        Vector4D(rawValue: lhs * rhs.rawValue)
    }

    /// Divides each component by a scalar.
    public static func / (lhs: Vector4D, rhs: Float) -> Vector4D {
        Vector4D(rawValue: lhs.rawValue / rhs)
    }

    /// Multiplies corresponding components.
    public static func * (lhs: Vector4D, rhs: Vector4D) -> Vector4D {
        Vector4D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    /// Divides corresponding components.
    public static func / (lhs: Vector4D, rhs: Vector4D) -> Vector4D {
        Vector4D(rawValue: lhs.rawValue / rhs.rawValue)
    }

    public static func *= (lhs: inout Vector4D, rhs: Float) {
        lhs.rawValue *= rhs
    }

    public static func /= (lhs: inout Vector4D, rhs: Float) {
        lhs.rawValue /= rhs
    }

    public static func *= (lhs: inout Vector4D, rhs: Vector4D) {
        lhs.rawValue *= rhs.rawValue
    }

    public static func /= (lhs: inout Vector4D, rhs: Vector4D) {
        lhs.rawValue /= rhs.rawValue
    }
}

extension Vector4D: CustomStringConvertible {
    public var description: String {
        "Vector4D(x: \(x), y: \(y), z: \(z), w: \(w))"
    }
}
