import WebGPU

/// A mesh uploaded to the GPU, ready to be rendered.
///
/// A `GPUMesh` is immutable. To change its geometry, create a new one from the updated mesh.
@MainActor
public final class GPUMesh {
    /// The vertex positions, as `float32x2`.
    let positionBuffer: Buffer

    /// The vertex colors, as `float32x4`, or `nil` if the mesh has no colors.
    let colorBuffer: Buffer?

    /// The vertex texture coordinates, as `float32x2`, or `nil` if the mesh has no texture coordinates.
    let textureCoordinateBuffer: Buffer?

    /// The vertex indices, as `uint32`, or `nil` if the mesh isn't indexed.
    let indexBuffer: Buffer?

    /// The number of indices to draw if the mesh is indexed, otherwise the number of vertices.
    let count: Int

    /// How vertices are assembled into primitives.
    let topology: PrimitiveTopology

    /// Creates a GPU mesh from a 2D mesh, using the default device.
    public init(_ mesh: Mesh2D) {
        precondition(
            mesh.colors.map { $0.count == mesh.vertexCount } ?? true,
            "Mesh has \(mesh.colors?.count ?? 0) colors but \(mesh.vertexCount) positions")
        precondition(
            mesh.textureCoordinates.map { $0.count == mesh.vertexCount } ?? true,
            "Mesh has \(mesh.textureCoordinates?.count ?? 0) texture coordinates but \(mesh.vertexCount) positions")

        let device = Device.default.device
        positionBuffer = device.createBuffer(mesh.positions, usage: .vertex)
        colorBuffer = mesh.colors.map { device.createBuffer($0, usage: .vertex) }
        textureCoordinateBuffer = mesh.textureCoordinates.map { device.createBuffer($0, usage: .vertex) }
        indexBuffer = mesh.indices.map { device.createBuffer($0, usage: .index) }
        count = mesh.indices?.count ?? mesh.vertexCount
        topology = PrimitiveTopology(mesh.topology)
    }
}

extension WebGPU.Device {
    /// Creates a buffer containing `elements`.
    fileprivate func createBuffer<Element>(_ elements: [Element], usage: BufferUsage) -> Buffer {
        elements.withUnsafeBytes { bytes in
            guard let buffer = createBuffer(descriptor: BufferDescriptor(
                usage: usage,
                size: UInt64(bytes.count),
                mappedAtCreation: true))
            else {
                preconditionFailure("Failed to create a GPU buffer of \(bytes.count) bytes")
            }
            if !bytes.isEmpty {
                UnsafeMutableRawBufferPointer(start: buffer.getMappedRange()!, count: bytes.count).copyMemory(from: bytes)
            }
            buffer.unmap()
            return buffer
        }
    }
}
