/// How a mesh's vertices are assembled into primitives.
public enum MeshTopology: String, Hashable, Codable, Sendable {
    /// Each vertex is a separate point.
    case points
    /// Each pair of vertices is a separate line.
    case lines
    /// Each vertex after the first is joined to the previous one by a line.
    case lineStrip
    /// Each group of three vertices is a separate triangle.
    case triangles
    /// Each vertex after the second forms a triangle with the previous two.
    case triangleStrip
}
