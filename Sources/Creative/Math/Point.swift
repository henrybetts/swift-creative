// Generated from Point.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.

/// A position in 2D space.
public struct Point2D: SIMDRepresentable {
    /// The underlying SIMD value.
    public var rawValue: SIMD2<Float>

    /// Creates a point from a SIMD value.
    public init(rawValue: SIMD2<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a point with the given components.
    public init(_ x: Float, _ y: Float) {
        self.init(rawValue: SIMD2<Float>(x, y))
    }

    /// Creates a point with the given components.
    public init(x: Float, y: Float) {
        self.init(rawValue: SIMD2<Float>(x, y))
    }

    /// Creates a point at the position `vector` points to from the origin.
    public init(_ vector: Vector2D) {
        self.init(rawValue: vector.rawValue)
    }

    /// Creates a point with the components of `size`.
    public init(_ size: Size2D) {
        self.init(rawValue: size.rawValue)
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

extension Point2D {
    /// The point with all components set to zero.
    public static let origin = Point2D(rawValue: .zero)

    /// The squared distance from this point to `other`. Cheaper than `distance(to:)` when only comparing distances.
    public func distanceSquared(to other: Point2D) -> Float {
        (other - self).lengthSquared
    }

    /// The distance from this point to `other`.
    public func distance(to other: Point2D) -> Float {
        (other - self).length
    }
}

extension Point2D {
    /// The vector from `rhs` to `lhs`.
    public static func - (lhs: Point2D, rhs: Point2D) -> Vector2D {
        Vector2D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Offsets a point by a vector.
    public static func + (lhs: Point2D, rhs: Vector2D) -> Point2D {
        Point2D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    /// Offsets a point by the negation of a vector.
    public static func - (lhs: Point2D, rhs: Vector2D) -> Point2D {
        Point2D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Offsets a point by a vector.
    public static func += (lhs: inout Point2D, rhs: Vector2D) {
        lhs.rawValue += rhs.rawValue
    }

    /// Offsets a point by the negation of a vector.
    public static func -= (lhs: inout Point2D, rhs: Vector2D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Point2D {
    /// Offsets a point by a size, e.g. to find the opposite corner of a rectangle.
    public static func + (lhs: Point2D, rhs: Size2D) -> Point2D {
        Point2D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    /// Offsets a point by the negation of a size.
    public static func - (lhs: Point2D, rhs: Size2D) -> Point2D {
        Point2D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Multiplies each component by the corresponding component of a size, e.g. to map normalized coordinates into a size.
    public static func * (lhs: Point2D, rhs: Size2D) -> Point2D {
        Point2D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    /// Divides each component by the corresponding component of a size, e.g. to normalize coordinates within a size.
    public static func / (lhs: Point2D, rhs: Size2D) -> Point2D {
        Point2D(rawValue: lhs.rawValue / rhs.rawValue)
    }

    /// Offsets a point by a size.
    public static func += (lhs: inout Point2D, rhs: Size2D) {
        lhs.rawValue += rhs.rawValue
    }

    /// Offsets a point by the negation of a size.
    public static func -= (lhs: inout Point2D, rhs: Size2D) {
        lhs.rawValue -= rhs.rawValue
    }

    /// Multiplies each component by the corresponding component of a size.
    public static func *= (lhs: inout Point2D, rhs: Size2D) {
        lhs.rawValue *= rhs.rawValue
    }

    /// Divides each component by the corresponding component of a size.
    public static func /= (lhs: inout Point2D, rhs: Size2D) {
        lhs.rawValue /= rhs.rawValue
    }
}

extension Point2D: CustomStringConvertible {
    public var description: String {
        "Point2D(x: \(x), y: \(y))"
    }
}

extension Vector2D {
    /// Creates a vector from the origin to `point`.
    public init(_ point: Point2D) {
        self.init(rawValue: point.rawValue)
    }
}

/// A position in 3D space.
public struct Point3D: SIMDRepresentable {
    /// The underlying SIMD value.
    public var rawValue: SIMD3<Float>

    /// Creates a point from a SIMD value.
    public init(rawValue: SIMD3<Float>) {
        self.rawValue = rawValue
    }

    /// Creates a point with the given components.
    public init(_ x: Float, _ y: Float, _ z: Float) {
        self.init(rawValue: SIMD3<Float>(x, y, z))
    }

    /// Creates a point with the given components.
    public init(x: Float, y: Float, z: Float) {
        self.init(rawValue: SIMD3<Float>(x, y, z))
    }

    /// Creates a point at the position `vector` points to from the origin.
    public init(_ vector: Vector3D) {
        self.init(rawValue: vector.rawValue)
    }

    /// Creates a point with the components of `size`.
    public init(_ size: Size3D) {
        self.init(rawValue: size.rawValue)
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

extension Point3D {
    /// The point with all components set to zero.
    public static let origin = Point3D(rawValue: .zero)

    /// The squared distance from this point to `other`. Cheaper than `distance(to:)` when only comparing distances.
    public func distanceSquared(to other: Point3D) -> Float {
        (other - self).lengthSquared
    }

    /// The distance from this point to `other`.
    public func distance(to other: Point3D) -> Float {
        (other - self).length
    }
}

extension Point3D {
    /// The vector from `rhs` to `lhs`.
    public static func - (lhs: Point3D, rhs: Point3D) -> Vector3D {
        Vector3D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Offsets a point by a vector.
    public static func + (lhs: Point3D, rhs: Vector3D) -> Point3D {
        Point3D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    /// Offsets a point by the negation of a vector.
    public static func - (lhs: Point3D, rhs: Vector3D) -> Point3D {
        Point3D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Offsets a point by a vector.
    public static func += (lhs: inout Point3D, rhs: Vector3D) {
        lhs.rawValue += rhs.rawValue
    }

    /// Offsets a point by the negation of a vector.
    public static func -= (lhs: inout Point3D, rhs: Vector3D) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Point3D {
    /// Offsets a point by a size, e.g. to find the opposite corner of a rectangle.
    public static func + (lhs: Point3D, rhs: Size3D) -> Point3D {
        Point3D(rawValue: lhs.rawValue + rhs.rawValue)
    }

    /// Offsets a point by the negation of a size.
    public static func - (lhs: Point3D, rhs: Size3D) -> Point3D {
        Point3D(rawValue: lhs.rawValue - rhs.rawValue)
    }

    /// Multiplies each component by the corresponding component of a size, e.g. to map normalized coordinates into a size.
    public static func * (lhs: Point3D, rhs: Size3D) -> Point3D {
        Point3D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    /// Divides each component by the corresponding component of a size, e.g. to normalize coordinates within a size.
    public static func / (lhs: Point3D, rhs: Size3D) -> Point3D {
        Point3D(rawValue: lhs.rawValue / rhs.rawValue)
    }

    /// Offsets a point by a size.
    public static func += (lhs: inout Point3D, rhs: Size3D) {
        lhs.rawValue += rhs.rawValue
    }

    /// Offsets a point by the negation of a size.
    public static func -= (lhs: inout Point3D, rhs: Size3D) {
        lhs.rawValue -= rhs.rawValue
    }

    /// Multiplies each component by the corresponding component of a size.
    public static func *= (lhs: inout Point3D, rhs: Size3D) {
        lhs.rawValue *= rhs.rawValue
    }

    /// Divides each component by the corresponding component of a size.
    public static func /= (lhs: inout Point3D, rhs: Size3D) {
        lhs.rawValue /= rhs.rawValue
    }
}

extension Point3D: CustomStringConvertible {
    public var description: String {
        "Point3D(x: \(x), y: \(y), z: \(z))"
    }
}

extension Vector3D {
    /// Creates a vector from the origin to `point`.
    public init(_ point: Point3D) {
        self.init(rawValue: point.rawValue)
    }
}
