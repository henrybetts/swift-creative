import Testing
@testable import Creative

@MainActor @Suite struct EventTests {
    @Test func callsHandlersInOrderWithValue() {
        let event = Event<Int>()
        var calls: [String] = []
        event.addHandler { calls.append("a\($0)") }
        event { calls.append("b\($0)") }

        event.trigger(1)
        event.trigger(2)
        #expect(calls == ["a1", "b1", "a2", "b2"])
    }

    @Test func triggerWithoutValue() {
        let event = Event<Void>()
        var count = 0
        event { count += 1 }

        event.trigger()
        #expect(count == 1)
    }

    @Test func removeHandler() {
        let event = Event<Void>()
        var calls: [String] = []
        let a = event { calls.append("a") }
        event { calls.append("b") }

        event.removeHandler(a)
        event.trigger()
        #expect(calls == ["b"])

        event.removeHandler(a)
        event.trigger()
        #expect(calls == ["b", "b"])
    }

    @Test func removeFromHandler() {
        let event = Event<Void>()
        var calls: [String] = []
        let a = event { calls.append("a") }
        event { calls.append("b") }

        a.remove()
        event.trigger()
        #expect(calls == ["b"])

        a.remove()
        event.trigger()
        #expect(calls == ["b", "b"])
    }

    @Test func removeAll() {
        let event = Event<Void>()
        var count = 0
        event { count += 1 }
        event { count += 1 }

        event.removeAll()
        event.trigger()
        #expect(count == 0)
    }

    @Test func changesDuringTriggerTakeEffectFromNextCall() {
        let event = Event<Void>()
        var calls: [String] = []
        var b: EventHandler?
        let a = event {
            calls.append("a")
            b?.remove()
            event { calls.append("c") }
        }
        b = event { calls.append("b") }

        event.trigger()
        #expect(calls == ["a", "b"])

        a.remove()
        calls.removeAll()
        event.trigger()
        #expect(calls == ["c"])
    }

    @Test func removeAfterEventIsDeallocated() {
        var event: Event<Void>? = Event()
        let handler = event!.addHandler {}
        event = nil

        handler.remove()
    }
}
