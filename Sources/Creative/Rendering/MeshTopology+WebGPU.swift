import WebGPU

extension PrimitiveTopology {
    /// Creates a WebGPU primitive topology from a mesh topology.
    init(_ topology: MeshTopology) {
        switch topology {
        case .points: self = .pointList
        case .lines: self = .lineList
        case .lineStrip: self = .lineStrip
        case .triangles: self = .triangleList
        case .triangleStrip: self = .triangleStrip
        }
    }
}
