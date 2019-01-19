//
//  ReferencesTracer.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

#if TRACE_REFERENCE_COUNT
fileprivate var referencesCount = 0
public struct ReferencesTracer {
    public static var count: Int {
        return referencesCount
    }
    
    public static func increment() {
        referencesCount+=1
    }
    
    public static func decrement() {
        referencesCount-=1
    }
}
#endif

public class ReferenceTracableObject {
    
    init() {
        #if TRACE_REFERENCE_COUNT
        ReferencesTracer.increment()
        #endif
    }
    
    deinit {
        #if TRACE_REFERENCE_COUNT
        ReferencesTracer.decrement()
        #endif
    }
}

