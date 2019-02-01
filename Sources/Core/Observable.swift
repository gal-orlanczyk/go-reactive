//
//  Observable.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 24/12/2018.
//

import Foundation

/// A type erased object implementing `ObservableProtocol` (for more read about "type erasure" in swift).
public class Observable<E>: ReferenceTracableObject, ObservableProtocol {
    
    public typealias Element = E
    
    public func subscribe<O: ObserverProtocol>(_ observer: O) -> Cancelable where E == O.Element {
        fatalError("abstract method")
    }
    
    public func asObservable() -> Observable<E> {
        return self
    }
}
