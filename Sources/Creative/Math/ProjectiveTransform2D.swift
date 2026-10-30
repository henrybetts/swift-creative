/// A 2D projective transformation.
public struct ProjectiveTransform2D: RawRepresentable, Hashable, Sendable {
    /// The underlying matrix.
    public var rawValue: Matrix3x3

    /// Creates a transform from a matrix.
    public init(rawValue: Matrix3x3) {
        self.rawValue = rawValue
    }

    /// Creates a transform from a matrix.
    public init(_ matrix: Matrix3x3) {
        self.init(rawValue: matrix)
    }

    /// Creates a transform equivalent to an affine transform.
    public init(_ transform: AffineTransform2D) {
        let linearColumns = transform.linearTransform.columns
        self.init(rawValue: Matrix3x3(
            Vector3D(linearColumns.0, 0),
            Vector3D(linearColumns.1, 0),
            Vector3D(transform.translation, 1)))
    }

    /// The underlying matrix.
    public var matrix: Matrix3x3 {
        get { rawValue }
        set { rawValue = newValue }
    }
}

extension ProjectiveTransform2D {
    /// The transform that leaves points unchanged.
    public static let identity = ProjectiveTransform2D(rawValue: .identity)

    /// The transform that undoes this one.
    ///
    /// The result contains non-finite values if the transform is singular (its matrix has a determinant of zero).
    public var inverse: ProjectiveTransform2D {
        ProjectiveTransform2D(rawValue: rawValue.inverse)
    }
}

extension ProjectiveTransform2D {
    /// The composition of two transforms, which applies `rhs` first, then `lhs`.
    public static func * (lhs: ProjectiveTransform2D, rhs: ProjectiveTransform2D) -> ProjectiveTransform2D {
        ProjectiveTransform2D(rawValue: lhs.rawValue * rhs.rawValue)
    }

    public static func *= (lhs: inout ProjectiveTransform2D, rhs: ProjectiveTransform2D) {
        lhs = lhs * rhs
    }

    /// Transforms a point.
    ///
    /// The result contains non-finite values if the transform maps the point to infinity.
    public static func * (lhs: ProjectiveTransform2D, rhs: Point2D) -> Point2D {
        let homogeneous = lhs.rawValue * Vector3D(Vector2D(rhs), 1)
        return Point2D(rawValue: homogeneous.xy.rawValue / homogeneous.z)
    }
}

extension ProjectiveTransform2D: Codable {
    public init(from decoder: any Decoder) throws {
        self.init(rawValue: try Matrix3x3(from: decoder))
    }

    public func encode(to encoder: any Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}

extension ProjectiveTransform2D: CustomStringConvertible {
    public var description: String {
        "ProjectiveTransform2D(\(rawValue))"
    }
}
