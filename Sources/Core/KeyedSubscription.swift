//
//  KeyedSubscription.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Defines a protocol for unsubscribing by key.
protocol KeyedUnsubscriber: class {
    associatedtype Key
    func unsubscribe(key: Key)
}

/// Defines a keyed subscription that can be unsubscribed using the unsubscriber object.
class KeyedSubscription<T: KeyedUnsubscriber>: Cancelable {
    
    private let key: T.Key
    private weak var keyedUnsubscriber: T?
    
    init(keyedUnsubscriber: T?, key: T.Key) {
        self.keyedUnsubscriber = keyedUnsubscriber
        self.key = key
    }
    
    public func cancel() {
        self.keyedUnsubscriber?.unsubscribe(key: key)
    }
}
