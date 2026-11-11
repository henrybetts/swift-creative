/// A collection of 2D vertices, with optional per-vertex attributes, assembled into primitives.
public struct Mesh2D: Hashable, Codable, Sendable {
    /// The position of each vertex.
    public var positions: [Point2D]

    /// The color of each vertex, if any. Expected to have the same count as `positions`.
    public var colors: [Color]?

    /// The texture coordinates of each vertex, if any. Expected to have the same count as `positions`.
    public var textureCoordinates: [Point2D]?

    /// The order in which vertices are assembled into primitives, or `nil` to use them in order.
    ///
    /// Each index is expected to be less than the number of vertices.
    public var indices: [UInt32]?

    /// How vertices are assembled into primitives.
    public var topology: MeshTopology

    /// Creates a mesh with the given vertex data.
    public init(
        positions: [Point2D] = [],
        colors: [Color]? = nil,
        textureCoordinates: [Point2D]? = nil,
        indices: [UInt32]? = nil,
        topology: MeshTopology = .triangles
    ) {
        self.positions = positions
        self.colors = colors
        self.textureCoordinates = textureCoordinates
        self.indices = indices
        self.topology = topology
    }

    /// The number of vertices.
    public var vertexCount: Int {
        positions.count
    }
}
