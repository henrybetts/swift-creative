/// An event that calls any number of handlers, in the order they were added.
@MainActor
public final class Event<Value> {
    private var handlers: [(handler: EventHandler, call: (Value) -> Void)] = []

    init() {}

    /// Adds a handler that is called each time the event occurs.
    @discardableResult
    public func callAsFunction(_ call: @escaping (Value) -> Void) -> EventHandler {
        addHandler(call)
    }

    /// Adds a handler that is called each time the event occurs.
    @discardableResult
    public func addHandler(_ call: @escaping (Value) -> Void) -> EventHandler {
        let handler = EventHandler { [weak self] in self?.removeHandler($0) }
        handlers.append((handler, call))
        return handler
    }

    /// Removes a handler so that it is no longer called.
    ///
    /// Has no effect if it was already removed.
    public func removeHandler(_ handler: EventHandler) {
        handlers.removeAll { $0.handler === handler }
    }

    /// Removes all handlers.
    func removeAll() {
        handlers.removeAll()
    }

    /// Calls each handler with `value`.
    ///
    /// Handlers added or removed by a handler take effect from the next call.
    func trigger(_ value: Value) {
        for (_, call) in handlers {
            call(value)
        }
    }
}

extension Event where Value == Void {
    /// Calls each handler.
    ///
    /// Handlers added or removed by a handler take effect from the next call.
    func trigger() {
        trigger(())
    }
}

/// A handler added to an event, which can be removed later.
@MainActor
public final class EventHandler {
    private var removeFromEvent: ((EventHandler) -> Void)?

    fileprivate init(removeFromEvent: @escaping (EventHandler) -> Void) {
        self.removeFromEvent = removeFromEvent
    }

    /// Removes the handler from its event so that it is no longer called.
    ///
    /// Has no effect if it was already removed.
    public func remove() {
        removeFromEvent?(self)
        removeFromEvent = nil
    }
}
