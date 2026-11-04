import Testing
@testable import Creative

@MainActor @Suite struct DeviceTests {
    struct BodyError: Error {}

    @Test func defaultIsAvailableOnlyWithinWithDefault() throws {
        let result = try Device.withDefault {
            _ = Device.default
            return 42
        }
        #expect(result == 42)
        #expect(Device._default == nil)
    }

    @Test func nestedCallReusesDefault() throws {
        try Device.withDefault {
            let outer = Device.default
            try Device.withDefault {
                #expect(Device.default === outer)
            }
            #expect(Device._default === outer)
        }
        #expect(Device._default == nil)
    }

    @Test func errorFromBodyPropagates() {
        #expect(throws: BodyError.self) {
            try Device.withDefault { throw BodyError() }
        }
        #expect(Device._default == nil)
    }
}
