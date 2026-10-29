// Generated from Matrix.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.

/// A 2x2 matrix, stored in column-major order.
public struct Matrix2x2: Sendable {
    /// The columns of the matrix.
    public var columns: (Vector2D, Vector2D)

    /// Creates a matrix with the given columns.
    public init(columns: (Vector2D, Vector2D)) {
        self.columns = columns
    }

    /// Creates a matrix with the given columns.
    public init(_ column0: Vector2D, _ column1: Vector2D) {
        self.init(columns: (column0, column1))
    }

    /// Creates a matrix with the given rows.
    public init(rows: (Vector2D, Vector2D)) {
        self = Matrix2x2(columns: rows).transpose
    }

    /// Creates a matrix with the given values on the diagonal and zero elsewhere.
    public init(diagonal: Vector2D) {
        let column0 = Vector2D(diagonal.x, 0)
        let column1 = Vector2D(0, diagonal.y)
        self.init(column0, column1)
    }

    /// The column at the given index.
    public subscript(column: Int) -> Vector2D {
        get {
            switch column {
            case 0: columns.0
            case 1: columns.1
            default: preconditionFailure("Column index out of range")
            }
        }
        set {
            switch column {
            case 0: columns.0 = newValue
            case 1: columns.1 = newValue
            default: preconditionFailure("Column index out of range")
            }
        }
    }

    /// The element at the given column and row.
    public subscript(column: Int, row: Int) -> Float {
        get { self[column].rawValue[row] }
        set { self[column].rawValue[row] = newValue }
    }
}

extension Matrix2x2 {
    /// The identity matrix.
    public static let identity = Matrix2x2(diagonal: .one)

    /// The matrix with its rows and columns swapped.
    public var transpose: Matrix2x2 {
        Matrix2x2(
            Vector2D(columns.0.x, columns.1.x),
            Vector2D(columns.0.y, columns.1.y)
        )
    }

    /// The determinant of the matrix.
    public var determinant: Float {
        columns.0.x * columns.1.y - columns.1.x * columns.0.y
    }

    /// The inverse of the matrix.
    ///
    /// The result contains non-finite values if the matrix is singular (its determinant is zero).
    public var inverse: Matrix2x2 {
        let inverseDeterminant = 1 / determinant
        return Matrix2x2(
            Vector2D(columns.1.y, -columns.0.y) * inverseDeterminant,
            Vector2D(-columns.1.x, columns.0.x) * inverseDeterminant
        )
    }
}

extension Matrix2x2 {
    /// The product of two matrices, which applies `rhs` first, then `lhs`.
    public static func * (lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
        Matrix2x2(lhs * rhs.columns.0, lhs * rhs.columns.1)
    }

    public static func *= (lhs: inout Matrix2x2, rhs: Matrix2x2) {
        lhs = lhs * rhs
    }

    /// Transforms a column vector by the matrix.
    public static func * (lhs: Matrix2x2, rhs: Vector2D) -> Vector2D {
        lhs.columns.0 * rhs.x + lhs.columns.1 * rhs.y
    }

    /// Multiplies a row vector by the matrix. Equivalent to `rhs.transpose * lhs`.
    public static func * (lhs: Vector2D, rhs: Matrix2x2) -> Vector2D {
        Vector2D(lhs.dot(rhs.columns.0), lhs.dot(rhs.columns.1))
    }
}

extension Matrix2x2: AdditiveArithmetic {
    /// A matrix with all elements set to zero.
    public static let zero = Matrix2x2(diagonal: .zero)

    public static func + (lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
        Matrix2x2(lhs.columns.0 + rhs.columns.0, lhs.columns.1 + rhs.columns.1)
    }

    public static func - (lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
        Matrix2x2(lhs.columns.0 - rhs.columns.0, lhs.columns.1 - rhs.columns.1)
    }

    public static func += (lhs: inout Matrix2x2, rhs: Matrix2x2) {
        lhs = lhs + rhs
    }

    public static func -= (lhs: inout Matrix2x2, rhs: Matrix2x2) {
        lhs = lhs - rhs
    }
}

extension Matrix2x2 {
    /// Negates each element.
    public static prefix func - (matrix: Matrix2x2) -> Matrix2x2 {
        Matrix2x2(-matrix.columns.0, -matrix.columns.1)
    }

    /// Multiplies each element by a scalar.
    public static func * (lhs: Matrix2x2, rhs: Float) -> Matrix2x2 {
        Matrix2x2(lhs.columns.0 * rhs, lhs.columns.1 * rhs)
    }

    /// Multiplies each element by a scalar.
    public static func * (lhs: Float, rhs: Matrix2x2) -> Matrix2x2 {
        rhs * lhs
    }

    /// Divides each element by a scalar.
    public static func / (lhs: Matrix2x2, rhs: Float) -> Matrix2x2 {
        Matrix2x2(lhs.columns.0 / rhs, lhs.columns.1 / rhs)
    }

    public static func *= (lhs: inout Matrix2x2, rhs: Float) {
        lhs = lhs * rhs
    }

    public static func /= (lhs: inout Matrix2x2, rhs: Float) {
        lhs = lhs / rhs
    }
}

extension Matrix2x2: Hashable {
    public static func == (lhs: Matrix2x2, rhs: Matrix2x2) -> Bool {
        lhs.columns.0 == rhs.columns.0 && lhs.columns.1 == rhs.columns.1
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(columns.0)
        hasher.combine(columns.1)
    }
}

/// Encoded as an array of columns, e.g. `[[1, 0], [0, 1]]`.
extension Matrix2x2: Codable {
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.init(try container.decode(Vector2D.self), try container.decode(Vector2D.self))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(columns.0)
        try container.encode(columns.1)
    }
}

extension Matrix2x2: CustomStringConvertible {
    public var description: String {
        "Matrix2x2(columns: (\(columns.0), \(columns.1)))"
    }
}

/// A 3x3 matrix, stored in column-major order.
public struct Matrix3x3: Sendable {
    /// The columns of the matrix.
    public var columns: (Vector3D, Vector3D, Vector3D)

    /// Creates a matrix with the given columns.
    public init(columns: (Vector3D, Vector3D, Vector3D)) {
        self.columns = columns
    }

    /// Creates a matrix with the given columns.
    public init(_ column0: Vector3D, _ column1: Vector3D, _ column2: Vector3D) {
        self.init(columns: (column0, column1, column2))
    }

    /// Creates a matrix with the given rows.
    public init(rows: (Vector3D, Vector3D, Vector3D)) {
        self = Matrix3x3(columns: rows).transpose
    }

    /// Creates a matrix with the given values on the diagonal and zero elsewhere.
    public init(diagonal: Vector3D) {
        let column0 = Vector3D(diagonal.x, 0, 0)
        let column1 = Vector3D(0, diagonal.y, 0)
        let column2 = Vector3D(0, 0, diagonal.z)
        self.init(column0, column1, column2)
    }

    /// The column at the given index.
    public subscript(column: Int) -> Vector3D {
        get {
            switch column {
            case 0: columns.0
            case 1: columns.1
            case 2: columns.2
            default: preconditionFailure("Column index out of range")
            }
        }
        set {
            switch column {
            case 0: columns.0 = newValue
            case 1: columns.1 = newValue
            case 2: columns.2 = newValue
            default: preconditionFailure("Column index out of range")
            }
        }
    }

    /// The element at the given column and row.
    public subscript(column: Int, row: Int) -> Float {
        get { self[column].rawValue[row] }
        set { self[column].rawValue[row] = newValue }
    }
}

extension Matrix3x3 {
    /// The identity matrix.
    public static let identity = Matrix3x3(diagonal: .one)

    /// The matrix with its rows and columns swapped.
    public var transpose: Matrix3x3 {
        Matrix3x3(
            Vector3D(columns.0.x, columns.1.x, columns.2.x),
            Vector3D(columns.0.y, columns.1.y, columns.2.y),
            Vector3D(columns.0.z, columns.1.z, columns.2.z)
        )
    }

    /// The determinant of the matrix.
    public var determinant: Float {
        columns.0.dot(columns.1.cross(columns.2))
    }

    /// The inverse of the matrix.
    ///
    /// The result contains non-finite values if the matrix is singular (its determinant is zero).
    public var inverse: Matrix3x3 {
        // Based on Eric Lengyel's formulation in Foundations of Game Engine Development, Volume 1.
        let (a, b, c) = columns
        let row0 = b.cross(c)
        let row1 = c.cross(a)
        let row2 = a.cross(b)
        let inverseDeterminant = 1 / row2.dot(c)
        return Matrix3x3(rows: (row0, row1, row2)) * inverseDeterminant
    }
}

extension Matrix3x3 {
    /// The product of two matrices, which applies `rhs` first, then `lhs`.
    public static func * (lhs: Matrix3x3, rhs: Matrix3x3) -> Matrix3x3 {
        Matrix3x3(lhs * rhs.columns.0, lhs * rhs.columns.1, lhs * rhs.columns.2)
    }

    public static func *= (lhs: inout Matrix3x3, rhs: Matrix3x3) {
        lhs = lhs * rhs
    }

    /// Transforms a column vector by the matrix.
    public static func * (lhs: Matrix3x3, rhs: Vector3D) -> Vector3D {
        lhs.columns.0 * rhs.x + lhs.columns.1 * rhs.y + lhs.columns.2 * rhs.z
    }

    /// Multiplies a row vector by the matrix. Equivalent to `rhs.transpose * lhs`.
    public static func * (lhs: Vector3D, rhs: Matrix3x3) -> Vector3D {
        Vector3D(lhs.dot(rhs.columns.0), lhs.dot(rhs.columns.1), lhs.dot(rhs.columns.2))
    }
}

extension Matrix3x3: AdditiveArithmetic {
    /// A matrix with all elements set to zero.
    public static let zero = Matrix3x3(diagonal: .zero)

    public static func + (lhs: Matrix3x3, rhs: Matrix3x3) -> Matrix3x3 {
        Matrix3x3(lhs.columns.0 + rhs.columns.0, lhs.columns.1 + rhs.columns.1, lhs.columns.2 + rhs.columns.2)
    }

    public static func - (lhs: Matrix3x3, rhs: Matrix3x3) -> Matrix3x3 {
        Matrix3x3(lhs.columns.0 - rhs.columns.0, lhs.columns.1 - rhs.columns.1, lhs.columns.2 - rhs.columns.2)
    }

    public static func += (lhs: inout Matrix3x3, rhs: Matrix3x3) {
        lhs = lhs + rhs
    }

    public static func -= (lhs: inout Matrix3x3, rhs: Matrix3x3) {
        lhs = lhs - rhs
    }
}

extension Matrix3x3 {
    /// Negates each element.
    public static prefix func - (matrix: Matrix3x3) -> Matrix3x3 {
        Matrix3x3(-matrix.columns.0, -matrix.columns.1, -matrix.columns.2)
    }

    /// Multiplies each element by a scalar.
    public static func * (lhs: Matrix3x3, rhs: Float) -> Matrix3x3 {
        Matrix3x3(lhs.columns.0 * rhs, lhs.columns.1 * rhs, lhs.columns.2 * rhs)
    }

    /// Multiplies each element by a scalar.
    public static func * (lhs: Float, rhs: Matrix3x3) -> Matrix3x3 {
        rhs * lhs
    }

    /// Divides each element by a scalar.
    public static func / (lhs: Matrix3x3, rhs: Float) -> Matrix3x3 {
        Matrix3x3(lhs.columns.0 / rhs, lhs.columns.1 / rhs, lhs.columns.2 / rhs)
    }

    public static func *= (lhs: inout Matrix3x3, rhs: Float) {
        lhs = lhs * rhs
    }

    public static func /= (lhs: inout Matrix3x3, rhs: Float) {
        lhs = lhs / rhs
    }
}

extension Matrix3x3: Hashable {
    public static func == (lhs: Matrix3x3, rhs: Matrix3x3) -> Bool {
        lhs.columns.0 == rhs.columns.0 && lhs.columns.1 == rhs.columns.1 && lhs.columns.2 == rhs.columns.2
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(columns.0)
        hasher.combine(columns.1)
        hasher.combine(columns.2)
    }
}

/// Encoded as an array of columns, e.g. `[[1, 0], [0, 1]]`.
extension Matrix3x3: Codable {
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.init(try container.decode(Vector3D.self), try container.decode(Vector3D.self), try container.decode(Vector3D.self))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(columns.0)
        try container.encode(columns.1)
        try container.encode(columns.2)
    }
}

extension Matrix3x3: CustomStringConvertible {
    public var description: String {
        "Matrix3x3(columns: (\(columns.0), \(columns.1), \(columns.2)))"
    }
}

/// A 4x4 matrix, stored in column-major order.
public struct Matrix4x4: Sendable {
    /// The columns of the matrix.
    public var columns: (Vector4D, Vector4D, Vector4D, Vector4D)

    /// Creates a matrix with the given columns.
    public init(columns: (Vector4D, Vector4D, Vector4D, Vector4D)) {
        self.columns = columns
    }

    /// Creates a matrix with the given columns.
    public init(_ column0: Vector4D, _ column1: Vector4D, _ column2: Vector4D, _ column3: Vector4D) {
        self.init(columns: (column0, column1, column2, column3))
    }

    /// Creates a matrix with the given rows.
    public init(rows: (Vector4D, Vector4D, Vector4D, Vector4D)) {
        self = Matrix4x4(columns: rows).transpose
    }

    /// Creates a matrix with the given values on the diagonal and zero elsewhere.
    public init(diagonal: Vector4D) {
        let column0 = Vector4D(diagonal.x, 0, 0, 0)
        let column1 = Vector4D(0, diagonal.y, 0, 0)
        let column2 = Vector4D(0, 0, diagonal.z, 0)
        let column3 = Vector4D(0, 0, 0, diagonal.w)
        self.init(column0, column1, column2, column3)
    }

    /// The column at the given index.
    public subscript(column: Int) -> Vector4D {
        get {
            switch column {
            case 0: columns.0
            case 1: columns.1
            case 2: columns.2
            case 3: columns.3
            default: preconditionFailure("Column index out of range")
            }
        }
        set {
            switch column {
            case 0: columns.0 = newValue
            case 1: columns.1 = newValue
            case 2: columns.2 = newValue
            case 3: columns.3 = newValue
            default: preconditionFailure("Column index out of range")
            }
        }
    }

    /// The element at the given column and row.
    public subscript(column: Int, row: Int) -> Float {
        get { self[column].rawValue[row] }
        set { self[column].rawValue[row] = newValue }
    }
}

extension Matrix4x4 {
    /// The identity matrix.
    public static let identity = Matrix4x4(diagonal: .one)

    /// The matrix with its rows and columns swapped.
    public var transpose: Matrix4x4 {
        Matrix4x4(
            Vector4D(columns.0.x, columns.1.x, columns.2.x, columns.3.x),
            Vector4D(columns.0.y, columns.1.y, columns.2.y, columns.3.y),
            Vector4D(columns.0.z, columns.1.z, columns.2.z, columns.3.z),
            Vector4D(columns.0.w, columns.1.w, columns.2.w, columns.3.w)
        )
    }

    /// The determinant of the matrix.
    public var determinant: Float {
        // Based on Eric Lengyel's formulation in Foundations of Game Engine Development, Volume 1.
        let (a, b, c, d) = (columns.0.xyz, columns.1.xyz, columns.2.xyz, columns.3.xyz)
        let (x, y, z, w) = (columns.0.w, columns.1.w, columns.2.w, columns.3.w)
        let s = a.cross(b)
        let t = c.cross(d)
        let u = a * y - b * x
        let v = c * w - d * z
        return s.dot(v) + t.dot(u)
    }

    /// The inverse of the matrix.
    ///
    /// The result contains non-finite values if the matrix is singular (its determinant is zero).
    public var inverse: Matrix4x4 {
        // Based on Eric Lengyel's formulation in Foundations of Game Engine Development, Volume 1.
        let (a, b, c, d) = (columns.0.xyz, columns.1.xyz, columns.2.xyz, columns.3.xyz)
        let (x, y, z, w) = (columns.0.w, columns.1.w, columns.2.w, columns.3.w)
        let s = a.cross(b)
        let t = c.cross(d)
        let u = a * y - b * x
        let v = c * w - d * z
        let inverseDeterminant = 1 / (s.dot(v) + t.dot(u))
        let row0 = Vector4D(b.cross(v) + t * y, -b.dot(t))
        let row1 = Vector4D(v.cross(a) - t * x, a.dot(t))
        let row2 = Vector4D(d.cross(u) + s * w, -d.dot(s))
        let row3 = Vector4D(u.cross(c) - s * z, c.dot(s))
        return Matrix4x4(rows: (row0, row1, row2, row3)) * inverseDeterminant
    }
}

extension Matrix4x4 {
    /// The product of two matrices, which applies `rhs` first, then `lhs`.
    public static func * (lhs: Matrix4x4, rhs: Matrix4x4) -> Matrix4x4 {
        Matrix4x4(lhs * rhs.columns.0, lhs * rhs.columns.1, lhs * rhs.columns.2, lhs * rhs.columns.3)
    }

    public static func *= (lhs: inout Matrix4x4, rhs: Matrix4x4) {
        lhs = lhs * rhs
    }

    /// Transforms a column vector by the matrix.
    public static func * (lhs: Matrix4x4, rhs: Vector4D) -> Vector4D {
        lhs.columns.0 * rhs.x + lhs.columns.1 * rhs.y + lhs.columns.2 * rhs.z + lhs.columns.3 * rhs.w
    }

    /// Multiplies a row vector by the matrix. Equivalent to `rhs.transpose * lhs`.
    public static func * (lhs: Vector4D, rhs: Matrix4x4) -> Vector4D {
        Vector4D(lhs.dot(rhs.columns.0), lhs.dot(rhs.columns.1), lhs.dot(rhs.columns.2), lhs.dot(rhs.columns.3))
    }
}

extension Matrix4x4: AdditiveArithmetic {
    /// A matrix with all elements set to zero.
    public static let zero = Matrix4x4(diagonal: .zero)

    public static func + (lhs: Matrix4x4, rhs: Matrix4x4) -> Matrix4x4 {
        Matrix4x4(lhs.columns.0 + rhs.columns.0, lhs.columns.1 + rhs.columns.1, lhs.columns.2 + rhs.columns.2, lhs.columns.3 + rhs.columns.3)
    }

    public static func - (lhs: Matrix4x4, rhs: Matrix4x4) -> Matrix4x4 {
        Matrix4x4(lhs.columns.0 - rhs.columns.0, lhs.columns.1 - rhs.columns.1, lhs.columns.2 - rhs.columns.2, lhs.columns.3 - rhs.columns.3)
    }

    public static func += (lhs: inout Matrix4x4, rhs: Matrix4x4) {
        lhs = lhs + rhs
    }

    public static func -= (lhs: inout Matrix4x4, rhs: Matrix4x4) {
        lhs = lhs - rhs
    }
}

extension Matrix4x4 {
    /// Negates each element.
    public static prefix func - (matrix: Matrix4x4) -> Matrix4x4 {
        Matrix4x4(-matrix.columns.0, -matrix.columns.1, -matrix.columns.2, -matrix.columns.3)
    }

    /// Multiplies each element by a scalar.
    public static func * (lhs: Matrix4x4, rhs: Float) -> Matrix4x4 {
        Matrix4x4(lhs.columns.0 * rhs, lhs.columns.1 * rhs, lhs.columns.2 * rhs, lhs.columns.3 * rhs)
    }

    /// Multiplies each element by a scalar.
    public static func * (lhs: Float, rhs: Matrix4x4) -> Matrix4x4 {
        rhs * lhs
    }

    /// Divides each element by a scalar.
    public static func / (lhs: Matrix4x4, rhs: Float) -> Matrix4x4 {
        Matrix4x4(lhs.columns.0 / rhs, lhs.columns.1 / rhs, lhs.columns.2 / rhs, lhs.columns.3 / rhs)
    }

    public static func *= (lhs: inout Matrix4x4, rhs: Float) {
        lhs = lhs * rhs
    }

    public static func /= (lhs: inout Matrix4x4, rhs: Float) {
        lhs = lhs / rhs
    }
}

extension Matrix4x4: Hashable {
    public static func == (lhs: Matrix4x4, rhs: Matrix4x4) -> Bool {
        lhs.columns.0 == rhs.columns.0 && lhs.columns.1 == rhs.columns.1 && lhs.columns.2 == rhs.columns.2 && lhs.columns.3 == rhs.columns.3
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(columns.0)
        hasher.combine(columns.1)
        hasher.combine(columns.2)
        hasher.combine(columns.3)
    }
}

/// Encoded as an array of columns, e.g. `[[1, 0], [0, 1]]`.
extension Matrix4x4: Codable {
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.init(try container.decode(Vector4D.self), try container.decode(Vector4D.self), try container.decode(Vector4D.self), try container.decode(Vector4D.self))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(columns.0)
        try container.encode(columns.1)
        try container.encode(columns.2)
        try container.encode(columns.3)
    }
}

extension Matrix4x4: CustomStringConvertible {
    public var description: String {
        "Matrix4x4(columns: (\(columns.0), \(columns.1), \(columns.2), \(columns.3)))"
    }
}
