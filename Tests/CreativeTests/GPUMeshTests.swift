import Testing
import WebGPU
@testable import Creative

@MainActor @Suite struct GPUMeshTests {
    let quad = Mesh2D(
        positions: [Point2D(0, 0), Point2D(1, 0), Point2D(1, 1), Point2D(0, 1)],
        colors: Array(repeating: .white, count: 4),
        textureCoordinates: [Point2D(0, 1), Point2D(1, 1), Point2D(1, 0), Point2D(0, 0)],
        indices: [0, 1, 2, 0, 2, 3])

    @Test func indexedMesh() throws {
        try Device.withDefault {
            let mesh = GPUMesh(quad)
            #expect(mesh.positionBuffer.size == 4 * 8)
            #expect(mesh.colorBuffer?.size == 4 * 16)
            #expect(mesh.textureCoordinateBuffer?.size == 4 * 8)
            #expect(mesh.indexBuffer?.size == 6 * 4)
            #expect(mesh.positionBuffer.usage == .vertex)
            #expect(mesh.indexBuffer?.usage == .index)
            #expect(mesh.count == 6)
            #expect(mesh.topology == .triangleList)
        }
    }

    @Test func positionsOnly() throws {
        try Device.withDefault {
            let mesh = GPUMesh(Mesh2D(positions: [Point2D(0, 0), Point2D(1, 0), Point2D(1, 1)], topology: .lineStrip))
            #expect(mesh.positionBuffer.size == 3 * 8)
            #expect(mesh.colorBuffer == nil)
            #expect(mesh.textureCoordinateBuffer == nil)
            #expect(mesh.indexBuffer == nil)
            #expect(mesh.count == 3)
            #expect(mesh.topology == .lineStrip)
        }
    }

    @Test func emptyMesh() throws {
        try Device.withDefault {
            let mesh = GPUMesh(Mesh2D())
            #expect(mesh.positionBuffer.size == 0)
            #expect(mesh.count == 0)
        }
    }
}
