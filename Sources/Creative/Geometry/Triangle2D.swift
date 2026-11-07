/// A triangle, with vertices in any winding order.
public struct Triangle2D: Sendable {
    /// The three vertices.
    public var vertices: (Point2D, Point2D, Point2D)

    /// Creates a triangle with the given vertices.
    public init(vertices: (Point2D, Point2D, Point2D)) {
        self.vertices = vertices
    }

    /// Creates a triangle with the given vertices.
    public init(_ a: Point2D, _ b: Point2D, _ c: Point2D) {
        self.init(vertices: (a, b, c))
    }
}

extension Triangle2D: Hashable {
    public static func == (lhs: Triangle2D, rhs: Triangle2D) -> Bool {
        lhs.vertices == rhs.vertices
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(vertices.0)
        hasher.combine(vertices.1)
        hasher.combine(vertices.2)
    }
}

/// Encoded as an array of vertices, e.g. `[[0, 0], [1, 0], [0, 1]]`.
extension Triangle2D: Codable {
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.init(
            try container.decode(Point2D.self),
            try container.decode(Point2D.self),
            try container.decode(Point2D.self))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(vertices.0)
        try container.encode(vertices.1)
        try container.encode(vertices.2)
    }
}

extension Triangle2D: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description, e.g. `[(0, 0), (1, 0), (0, 1)]`.
    public var description: String {
        "[\(vertices.0), \(vertices.1), \(vertices.2)]"
    }

    /// A description that constructs the same triangle as Swift code, e.g.
    /// `Triangle2D(Point2D(x: 0.0, y: 0.0), Point2D(x: 1.0, y: 0.0), Point2D(x: 0.0, y: 1.0))`.
    public var debugDescription: String {
        "Triangle2D(\(vertices.0.debugDescription), \(vertices.1.debugDescription), \(vertices.2.debugDescription))"
    }
}
