import Testing
@testable import Creative

@Suite struct FloatDisplayTests {
    @Test func displayDescription() {
        #expect(Float(90).displayDescription == "90")
        #expect(Float(-1.5).displayDescription == "-1.5")
        #expect(Float(135.00002).displayDescription == "135.00002")
        #expect(Float(1e10).displayDescription == "1e+10")
        #expect(Float.nan.displayDescription == "nan")
        #expect((-Float.infinity).displayDescription == "-inf")
    }
}
