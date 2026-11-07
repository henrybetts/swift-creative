/// A circle.
public struct Circle2D: Hashable, Codable, Sendable {
    /// The center point.
    public var center: Point2D

    /// The radius, which is expected to be non-negative.
    public var radius: Float

    /// Creates a circle with the given center and radius.
    public init(center: Point2D, radius: Float) {
        self.center = center
        self.radius = radius
    }
}

extension Circle2D: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description, e.g. `(1, 2) r3`.
    public var description: String {
        "\(center) r\(radius.displayDescription)"
    }

    /// A description that constructs the same circle as Swift code, e.g.
    /// `Circle2D(center: Point2D(x: 1.0, y: 2.0), radius: 3.0)`.
    public var debugDescription: String {
        "Circle2D(center: \(center.debugDescription), radius: \(radius))"
    }
}
