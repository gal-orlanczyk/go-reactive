//
//  ObservableContainerTests.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Represents a container for an observable sequence.
/// Used mainly to create new concrete observable objects easily.
final class ObservableContainer<E>: Observable<E> {
    
    let subscriptionHandler: SubscriptionHandler<E>
    
    init(_ subscriptionHandler: @escaping SubscriptionHandler<E>) {
        self.subscriptionHandler = subscriptionHandler
    }
    
    override func subscribe<O: ObserverProtocol>(_ observer: O) -> Cancelable where E == O.Element {
        let subscriptionCanceler = SubscriptionCanceler<O>()
        let forwarderObserver = ForwarderObserver(observer: observer, subscriptionCanceler: subscriptionCanceler)
        let subscription = forwarderObserver.subscribe(using: self.subscriptionHandler)
        subscriptionCanceler.set(forwarderObserver: forwarderObserver, subscription: subscription)
        return subscriptionCanceler
    }
}

final fileprivate class ForwarderObserver<O: ObserverProtocol>: ObserverProtocol, Cancelable {
    
    let observer: O
    var isCanceled = false
    weak var subscriptionCanceler: SubscriptionCanceler<O>?
    
    init(observer: O, subscriptionCanceler: SubscriptionCanceler<O>) {
        self.observer = observer
        self.subscriptionCanceler = subscriptionCanceler
    }
    
    func cancel() {
        self.subscriptionCanceler?.cancel()
        self.isCanceled = true
    }
    
    func on(_ event: Event<O.Element>) {
        guard self.isCanceled == false else { return }
        switch event {
        case .next(let value):
            self.observer.onNext(value)
        case .completed:
            self.observer.onCompleted()
            self.cancel()
        case .error(let error):
            self.observer.onError(error)
            self.cancel()
        }
    }
    
    func subscribe(using subscriptionHandler: SubscriptionHandler<O.Element>) -> Cancelable {
        return subscriptionHandler(Observer(self))
    }
}

final fileprivate class SubscriptionCanceler<O: ObserverProtocol>: Cancelable {
    
    private var forwarderObserver: ForwarderObserver<O>? = nil
    private var subscription: Cancelable? = nil
    
    fileprivate func set(forwarderObserver: ForwarderObserver<O>, subscription: Cancelable) {
        self.forwarderObserver = forwarderObserver
        self.subscription = subscription
    }
    
    fileprivate func cancel() {
        self.subscription?.cancel()
        self.forwarderObserver = nil
        self.subscription = nil
    }
}
