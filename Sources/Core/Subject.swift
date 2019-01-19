//
//  Subject.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// `Subject` represents an protocol for an object that can be both an observable and observer in a the same time.
public protocol Subject: ObservableProtocol, ObserverProtocol {}

public extension Bindable where Self: Subject {
    
    func bidirectionalBind<B: Bindable & Subject>(to bindable: B) -> Cancelable where B.Element == Element {
        let handlerContext = HandlerContext.nonCyclic()
        
        let firstWayBinding = self.subscribe { (event) in
            handlerContext.execute {
                bindable.on(event)
            }
        }
        let secondWayBinding = bindable.subscribe { (event) in
            handlerContext.execute {
                self.on(event)
            }
        }
        
        return CancelableGroup([firstWayBinding, secondWayBinding])
    }
}

fileprivate class HandlerContext {
    
    typealias Handler = (@escaping () -> Void) -> Void
    
    private let handler: Handler
    
    init(handler: @escaping Handler) {
        self.handler = handler
    }
    
    /// Execute given block in the context.
    func execute(_ block: @escaping () -> Void) {
        handler(block)
    }
    
    /// Execution context that breaks cyclic calls by ignoring them.
    static func nonCyclic() -> HandlerContext {
        var isBusy: Bool = false
        return HandlerContext { block in
            guard !isBusy else { return }
            isBusy = true
            block()
            isBusy = false
        }
    }
}
