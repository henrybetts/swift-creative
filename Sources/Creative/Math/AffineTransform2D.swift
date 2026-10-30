/// A 2D affine transformation.
public struct AffineTransform2D: Hashable, Sendable {
    /// The linear part of the transform, applied before the translation.
    public var linearTransform: Matrix2x2

    /// The translation, applied after the linear transform.
    public var translation: Vector2D

    /// Creates a transform from a linear transform and a translation.
    public init(linearTransform: Matrix2x2, translation: Vector2D) {
        self.linearTransform = linearTransform
        self.translation = translation
    }

    /// Creates a transform from the affine part of a projective transform, discarding its bottom row.
    ///
    /// The result only matches `transform` when its matrix's bottom row is `(0, 0, 1)`.
    public init(truncating transform: ProjectiveTransform2D) {
        let columns = transform.rawValue.columns
        self.init(linearTransform: Matrix2x2(columns.0.xy, columns.1.xy), translation: columns.2.xy)
    }
}

extension AffineTransform2D {
    /// Creates a transform that scales about the origin.
    public init(scale: Size2D) {
        self.init(linearTransform: Matrix2x2(diagonal: Vector2D(rawValue: scale.rawValue)), translation: .zero)
    }

    /// Creates a transform that rotates about the origin.
    ///
    /// Positive angles rotate from +x towards +y, which is counterclockwise when y points up
    /// and clockwise in y-down screen space.
    public init(rotation: Angle) {
        let cosine = cos(rotation)
        let sine = sin(rotation)
        self.init(linearTransform: Matrix2x2(Vector2D(cosine, sine), Vector2D(-sine, cosine)), translation: .zero)
    }

    /// Creates a transform that translates.
    public init(translation: Vector2D) {
        self.init(linearTransform: .identity, translation: translation)
    }

    /// Creates a transform that scales, then rotates, then translates.
    public init(scale: Size2D, rotation: Angle, translation: Vector2D) {
        let cosine = cos(rotation)
        let sine = sin(rotation)
        self.init(
            linearTransform: Matrix2x2(Vector2D(cosine, sine) * scale.width, Vector2D(-sine, cosine) * scale.height),
            translation: translation)
    }
}

extension AffineTransform2D {
    /// The transform that leaves points and vectors unchanged.
    public static let identity = AffineTransform2D(linearTransform: .identity, translation: .zero)

    /// The transform that undoes this one.
    ///
    /// The result contains non-finite values if the transform is singular (its linear transform has a determinant of zero).
    public var inverse: AffineTransform2D {
        let inverseLinearTransform = linearTransform.inverse
        return AffineTransform2D(linearTransform: inverseLinearTransform, translation: -(inverseLinearTransform * translation))
    }
}

extension AffineTransform2D {
    /// The composition of two transforms, which applies `rhs` first, then `lhs`.
    public static func * (lhs: AffineTransform2D, rhs: AffineTransform2D) -> AffineTransform2D {
        AffineTransform2D(
            linearTransform: lhs.linearTransform * rhs.linearTransform,
            translation: lhs.linearTransform * rhs.translation + lhs.translation)
    }

    public static func *= (lhs: inout AffineTransform2D, rhs: AffineTransform2D) {
        lhs = lhs * rhs
    }

    /// Transforms a point.
    public static func * (lhs: AffineTransform2D, rhs: Point2D) -> Point2D {
        Point2D(lhs.linearTransform * Vector2D(rhs) + lhs.translation)
    }

    /// Transforms a vector. Vectors are directions, so the translation doesn't apply.
    public static func * (lhs: AffineTransform2D, rhs: Vector2D) -> Vector2D {
        lhs.linearTransform * rhs
    }
}

/// Encoded with keys, e.g. `{"linearTransform": [[1, 0], [0, 1]], "translation": [0, 0]}`.
extension AffineTransform2D: Codable {}

extension AffineTransform2D: CustomStringConvertible {
    public var description: String {
        "AffineTransform2D(linearTransform: \(linearTransform), translation: \(translation))"
    }
}
