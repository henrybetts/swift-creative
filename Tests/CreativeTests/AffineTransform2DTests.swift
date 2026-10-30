import Foundation
import Testing
@testable import Creative

@Suite struct AffineTransform2DTests {
    let translation = AffineTransform2D(linearTransform: .identity, translation: Vector2D(2, 3))
    let scale = AffineTransform2D(linearTransform: Matrix2x2(diagonal: Vector2D(2, 2)), translation: .zero)
    let shearAndTranslation = AffineTransform2D(
        linearTransform: Matrix2x2(rows: (Vector2D(1, 1), Vector2D(0, 1))),
        translation: Vector2D(2, 3))

    @Test func properties() {
        var transform = AffineTransform2D.identity
        transform.linearTransform = Matrix2x2(diagonal: Vector2D(1, 2))
        transform.translation = Vector2D(3, 4)
        #expect(transform == AffineTransform2D(linearTransform: Matrix2x2(diagonal: Vector2D(1, 2)), translation: Vector2D(3, 4)))
    }

    @Test func identity() {
        #expect(AffineTransform2D.identity.linearTransform == .identity)
        #expect(AffineTransform2D.identity.translation == .zero)
        #expect(AffineTransform2D.identity * Point2D(1, 2) == Point2D(1, 2))
        #expect(AffineTransform2D.identity * Vector2D(1, 2) == Vector2D(1, 2))
    }

    @Test func scaleRotationAndTranslationInits() {
        #expect(AffineTransform2D(scale: Size2D(2, 3)) * Point2D(1, 1) == Point2D(2, 3))
        #expect(isApproximatelyEqual(AffineTransform2D(rotation: .quarterTurn) * Point2D(1, 0), Point2D(0, 1)))
        #expect(AffineTransform2D(translation: Vector2D(2, 3)) == translation)
    }

    @Test func combinedInit() {
        let transform = AffineTransform2D(scale: Size2D(2, 3), rotation: .quarterTurn, translation: Vector2D(4, 5))
        let composed = AffineTransform2D(translation: Vector2D(4, 5))
            * AffineTransform2D(rotation: .quarterTurn)
            * AffineTransform2D(scale: Size2D(2, 3))
        #expect(transform == composed)
        #expect(isApproximatelyEqual(transform * Point2D(1, 1), Point2D(1, 7)))
    }

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
        #expect(shearAndTranslation * Point2D(1, 1) == Point2D(4, 4))
    }

    @Test func transformingVectors() {
        // Vectors ignore the translation.
        #expect(translation * Vector2D(1, 1) == Vector2D(1, 1))
        #expect(shearAndTranslation * Vector2D(1, 1) == Vector2D(2, 1))
    }

    @Test func inverse() {
        #expect(shearAndTranslation.inverse * (shearAndTranslation * Point2D(1, 1)) == Point2D(1, 1))
        #expect(shearAndTranslation * shearAndTranslation.inverse == .identity)
    }

    @Test func projectiveConversion() {
        let projective = ProjectiveTransform2D(shearAndTranslation)
        #expect(projective.rawValue == Matrix3x3(rows: (Vector3D(1, 1, 2), Vector3D(0, 1, 3), Vector3D(0, 0, 1))))
        #expect(projective * Point2D(1, 1) == shearAndTranslation * Point2D(1, 1))
        #expect(AffineTransform2D(truncating: projective) == shearAndTranslation)
    }

    @Test func truncatingDropsProjectiveRow() {
        let perspective = ProjectiveTransform2D(Matrix3x3(rows: (Vector3D(1, 0, 2), Vector3D(0, 1, 3), Vector3D(0, 1, 1))))
        let truncated = AffineTransform2D(truncating: perspective)
        #expect(truncated == translation)
        #expect(truncated * Point2D(1, 1) != perspective * Point2D(1, 1))
    }

    @Test func codable() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(translation)
        #expect(String(decoding: data, as: UTF8.self) == #"{"linearTransform":[[1,0],[0,1]],"translation":[2,3]}"#)
        #expect(try JSONDecoder().decode(AffineTransform2D.self, from: data) == translation)
    }

    @Test func description() {
        #expect(AffineTransform2D.identity.description == "AffineTransform2D(linearTransform: \(Matrix2x2.identity), translation: \(Vector2D.zero))")
    }
}
