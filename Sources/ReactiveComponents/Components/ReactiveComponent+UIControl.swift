//
//  ReactiveComponent+UIControl.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import UIKit

public extension ReactiveComponent where Component: UIControl {
    
    public var isEnabled: Binder<Bool> {
        return binder { control, value in
            control.isEnabled = value
        }
    }
}

public extension ReactiveComponent where Component: UIControl {
    
    public func editableBidirectionalControlBinder<E>(getter: @escaping (Component) -> E, setter: @escaping (Component, E) -> Void) -> BidirectionalControlBinder<E> {
        
        return self.bidirectionalControlBinder(for: [.allEditingEvents, .valueChanged], getter: getter, setter: setter)
    }
    
    public func bidirectionalControlBinder<E>(for events: UIControl.Event, getter: @escaping (Component) -> E, setter: @escaping (Component, E) -> Void) -> BidirectionalControlBinder<E> {
        
        let observable = Observable<E>.create { [weak control = self.component] (observer) -> Cancelable in
            guard let strongControl = control else {
                observer.onCompleted()
                return Cancelables.create()
            }
            
            let controlTargetAction = ControlTargetAction(control: strongControl, events: events, eventHandler: { _ in
                if let control = control {
                    observer.onNext(getter(control))
                }
            })
            
            return controlTargetAction
        }// TODO: add take until deallocated
        
        let observer = Binder<E>(target: self.component, setter: setter)
        
        return BidirectionalControlBinder<E>(observable: observable, observer: observer)
    }
    
    public func controlObservable(for events: UIControl.Event) -> Observable<Void> {
        
        return Observable<Void>.create { [weak control = self.component] (observer) -> Cancelable in
            guard let strongControl = control else {
                observer.onCompleted()
                return Cancelables.create()
            }
            
            let controlTargetAction = ControlTargetAction(control: strongControl, events: events, eventHandler: { _ in
                observer.onNext(())
            })
            
            return controlTargetAction
        }// TODO: add take until deallocated
    }
    
}

final fileprivate class ControlTargetAction: Cancelable {
    
    public typealias EventHandler = (UIControl) -> Void
    
    let selector: Selector = #selector(eventHandler(_:))
    let events: UIControl.Event
    weak var control: UIControl?
    var eventHandler: EventHandler?
    
    init(control: UIControl, events: UIControl.Event, eventHandler: @escaping EventHandler) {
        self.control = control
        self.events = events
        self.eventHandler = eventHandler
        self.control?.addTarget(self, action: self.selector, for: events)
    }
    
    public func cancel() {
        self.control?.removeTarget(self, action: self.selector, for: self.events)
        self.eventHandler = nil
    }
    
    @objc private func eventHandler(_ sender: UIControl) {
        if let callback = self.eventHandler, let control = self.control {
            callback(control)
        }
    }
}
