/// A regular polygon, with its vertices evenly spaced around a circumscribed circle.
///
/// The first vertex lies on the circumcircle at angle 0, directly +x of the center.
public struct RegularPolygon2D: Hashable, Codable, Sendable {
    /// The circle passing through every vertex.
    public var circumcircle: Circle2D

    /// The number of sides, which is expected to be at least 3.
    public var sideCount: Int

    /// Creates a regular polygon with the given circumcircle and number of sides.
    public init(circumcircle: Circle2D, sideCount: Int) {
        self.circumcircle = circumcircle
        self.sideCount = sideCount
    }
}

extension RegularPolygon2D: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description, e.g. `(1, 2) r3 ×6`.
    public var description: String {
        "\(circumcircle) ×\(sideCount)"
    }

    /// A description that constructs the same polygon as Swift code, e.g.
    /// `RegularPolygon2D(circumcircle: Circle2D(center: Point2D(x: 1.0, y: 2.0), radius: 3.0), sideCount: 6)`.
    public var debugDescription: String {
        "RegularPolygon2D(circumcircle: \(circumcircle.debugDescription), sideCount: \(sideCount))"
    }
}
