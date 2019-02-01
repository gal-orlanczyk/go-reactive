//
//  BidirectionalBinder.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

public class BidirectionalControlBinder<Element>: BidirectionalBinder<Element> {
    
    public override func on(_ event: Event<Element>) {
        switch event {
        case .next(let value): self.observer.onNext(value)
        case .error, .completed: break
        }
    }
}

/// Represents bidirection binder object that helps with binding an observable sequence and an observer together as a subject.
public class BidirectionalBinder<Element>: Subject {
    
    let observable: Observable<Element>
    let observer: Observer<Element>
    
    public init<T: ObservableProtocol, S: ObserverProtocol>(observable: T, observer: S) where T.Element == Element, S.Element == Element {
        self.observable = observable.asObservable
        self.observer = observer.asObserver
    }
    
    public func subscribe<O: ObserverProtocol>(_ observer: O) -> Cancelable where Element == O.Element {
        return self.observable.subscribe(observer)
    }
    
    public func on(_ event: Event<Element>) {
        self.observer.on(event)
    }
    
    public var asObservable: Observable<Element> {
        return self.observable
    }
}

