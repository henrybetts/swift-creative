import Foundation
import Testing
@testable import Creative

@Suite struct Mesh2DTests {
    let quad = Mesh2D(
        positions: [Point2D(0, 0), Point2D(1, 0), Point2D(1, 1), Point2D(0, 1)],
        colors: Array(repeating: .white, count: 4),
        textureCoordinates: [Point2D(0, 1), Point2D(1, 1), Point2D(1, 0), Point2D(0, 0)],
        indices: [0, 1, 2, 0, 2, 3])

    @Test func defaultInit() {
        let mesh = Mesh2D()
        #expect(mesh.positions.isEmpty)
        #expect(mesh.colors == nil)
        #expect(mesh.textureCoordinates == nil)
        #expect(mesh.indices == nil)
        #expect(mesh.topology == .triangles)
    }

    @Test func vertexCount() {
        #expect(quad.vertexCount == 4)
    }

    @Test func codable() throws {
        let mesh = Mesh2D(positions: [Point2D(0, 0), Point2D(1, 0)], topology: .lines)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(mesh)
        #expect(String(decoding: data, as: UTF8.self) == #"{"positions":[[0,0],[1,0]],"topology":"lines"}"#)
        #expect(try JSONDecoder().decode(Mesh2D.self, from: data) == mesh)
        #expect(try JSONDecoder().decode(Mesh2D.self, from: encoder.encode(quad)) == quad)
    }

    @Test func meshIsSelf() {
        #expect(quad.mesh == quad)
    }
}
