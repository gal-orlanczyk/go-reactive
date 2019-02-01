//
//  Observers.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// `Observers` handles a list of observers, supports adding and removing as needed.
public struct Observers<T> {
    
    private var uid = (UInt64(0)...).makeIterator()
    private var observersMap = [UInt64 : T]()
    
    public mutating func insert(_ observer: T) -> UInt64 {
        let uid = self.uid.next()!
        self.observersMap[uid] = observer
        return uid
    }
    
    public mutating func remove(uid: UInt64) -> T? {
        let observer = self.observersMap[uid]
        self.observersMap[uid] = nil
        return observer
    }
    
    public mutating func removeAll() {
        self.observersMap.removeAll(keepingCapacity: false)
    }
    
    public var items: [T] {
        return Array(self.observersMap.values)
    }
}
