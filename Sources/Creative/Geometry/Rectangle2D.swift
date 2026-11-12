/// An axis-aligned rectangle.
///
/// The size may be negative, in which case `origin` isn't the minimum corner. Use `standardized` to get an
/// equivalent rectangle with a non-negative size.
public struct Rectangle2D: Hashable, Codable, Sendable {
    /// The corner the size extends from.
    public var origin: Point2D

    /// The extent from `origin`, which may be negative.
    public var size: Size2D

    /// Creates a rectangle with the given origin and size.
    public init(origin: Point2D, size: Size2D) {
        self.origin = origin
        self.size = size
    }

    /// Creates a rectangle with the given origin and size components.
    public init(x: Float, y: Float, width: Float, height: Float) {
        self.init(origin: Point2D(x, y), size: Size2D(width, height))
    }
}

extension Rectangle2D {
    /// The signed width.
    public var width: Float { size.width }

    /// The signed height.
    public var height: Float { size.height }

    /// The smallest x coordinate.
    public var minX: Float { min(origin.x, origin.x + size.width) }

    /// The largest x coordinate.
    public var maxX: Float { max(origin.x, origin.x + size.width) }

    /// The smallest y coordinate.
    public var minY: Float { min(origin.y, origin.y + size.height) }

    /// The largest y coordinate.
    public var maxY: Float { max(origin.y, origin.y + size.height) }

    /// The center point.
    public var center: Point2D {
        origin + Vector2D(size) * 0.5
    }

    /// An equivalent rectangle with a non-negative size, whose origin is the minimum corner.
    public var standardized: Rectangle2D {
        Rectangle2D(x: minX, y: minY, width: abs(size.width), height: abs(size.height))
    }
}

extension Rectangle2D: CustomStringConvertible, CustomDebugStringConvertible {
    /// A user-presentable description, e.g. `(1, 2) 3 × 4`.
    public var description: String {
        "\(origin) \(size)"
    }

    /// A description that constructs the same rectangle as Swift code, e.g.
    /// `Rectangle2D(x: 1.0, y: 2.0, width: 3.0, height: 4.0)`.
    public var debugDescription: String {
        "Rectangle2D(x: \(origin.x), y: \(origin.y), width: \(size.width), height: \(size.height))"
    }
}

extension Rectangle2D: Mesh2DConvertible {
    /// A mesh of this rectangle as two triangles, starting from the minimum corner.
    public var mesh: Mesh2D {
        Mesh2D(
            positions: [Point2D(minX, minY), Point2D(maxX, minY), Point2D(maxX, maxY), Point2D(minX, maxY)],
            indices: [0, 1, 2, 0, 2, 3])
    }
}
