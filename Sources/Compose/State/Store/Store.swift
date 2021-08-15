import Foundation
import SwiftUI

@propertyWrapper public struct Store<State : AnyState> : DynamicProperty, AnyStore {
    
    public var id : UUID {
        container.id
    }
    
    public var wrappedValue : State {
        get {
            container.state
        }
        nonmutating set {
            container.state = newValue
        }
    }
    
    public var projectedValue : BackingStore<State> {
        container
    }
    
    var willChange: AnyEmitter {
        container.willChange
    }
    
    var isMapped: Bool {
        false
    }
    
    @ObservedObject fileprivate var container : BackingStore<State>

    public init(storage : AnyPersistentStorage = EmptyPersistentStorage()) {
        container = .init(storage: storage)
    }
    
}

