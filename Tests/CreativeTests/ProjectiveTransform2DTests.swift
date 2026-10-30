import Foundation
import Testing
@testable import Creative

@Suite struct ProjectiveTransform2DTests {
    let translation = ProjectiveTransform2D(Matrix3x3(rows: (Vector3D(1, 0, 2), Vector3D(0, 1, 3), Vector3D(0, 0, 1))))
    let scale = ProjectiveTransform2D(Matrix3x3(diagonal: Vector3D(2, 2, 1)))
    let perspective = ProjectiveTransform2D(Matrix3x3(rows: (Vector3D(1, 0, 2), Vector3D(0, 1, 3), Vector3D(0, 1, 1))))

    @Test func rawValue() {
        let matrix = Matrix3x3(diagonal: Vector3D(1, 2, 3))
        #expect(ProjectiveTransform2D(matrix).rawValue == matrix)
        #expect(ProjectiveTransform2D(rawValue: matrix) == ProjectiveTransform2D(matrix))
        var transform = ProjectiveTransform2D.identity
        transform.matrix = matrix
        #expect(transform.matrix == matrix)
        #expect(transform.rawValue == matrix)
    }

    @Test func scaleRotationAndTranslationInits() {
        #expect(ProjectiveTransform2D(scale: Size2D(2, 3)) == ProjectiveTransform2D(AffineTransform2D(scale: Size2D(2, 3))))
        #expect(ProjectiveTransform2D(rotation: .quarterTurn) == ProjectiveTransform2D(AffineTransform2D(rotation: .quarterTurn)))
        #expect(ProjectiveTransform2D(translation: Vector2D(2, 3)) == translation)
        #expect(
            ProjectiveTransform2D(scale: Size2D(2, 3), rotation: .quarterTurn, translation: Vector2D(4, 5))
                == ProjectiveTransform2D(AffineTransform2D(scale: Size2D(2, 3), rotation: .quarterTurn, translation: Vector2D(4, 5))))
    }

    @Test func identity() {
        #expect(ProjectiveTransform2D.identity.rawValue == .identity)
        #expect(ProjectiveTransform2D.identity * Point2D(1, 2) == Point2D(1, 2))    }

    @Test func composition() {
        let scaleAfterTranslation = scale * translation
        let translationAfterScale = translation * scale
        #expect(scaleAfterTranslation * Point2D(1, 1) == Point2D(6, 8))
        #expect(translationAfterScale * Point2D(1, 1) == Point2D(4, 5))
        var transform = scale
        transform *= translation
        #expect(transform == scale * translation)
    }

    @Test func transformingPoints() {
        #expect(translation * Point2D(1, 1) == Point2D(3, 4))
        // The w coordinate is y + 1, so (1, 1) maps to (3, 4) / 2.
        #expect(perspective * Point2D(1, 1) == Point2D(1.5, 2))
        // The w coordinate is zero, so the point maps to infinity.
        #expect(!(perspective * Point2D(1, -1)).x.isFinite)
    }

    @Test func inverse() {
        #expect(perspective.inverse.rawValue == perspective.rawValue.inverse)
        #expect(perspective.inverse * (perspective * Point2D(1, 1)) == Point2D(1, 1))
        #expect(perspective * perspective.inverse == .identity)
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(translation)
        #expect(String(decoding: data, as: UTF8.self) == "[[1,0,0],[0,1,0],[2,3,1]]")
        #expect(try JSONDecoder().decode(ProjectiveTransform2D.self, from: data) == translation)
    }

    @Test func description() {
        #expect(translation.description == "[1, 0, 2; 0, 1, 3; 0, 0, 1]")
    }

    @Test func debugDescription() {
        #expect(translation.debugDescription == "ProjectiveTransform2D(Matrix3x3(columns: (Vector3D(x: 1.0, y: 0.0, z: 0.0), Vector3D(x: 0.0, y: 1.0, z: 0.0), Vector3D(x: 2.0, y: 3.0, z: 1.0))))")
    }
}
