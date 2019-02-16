# GoReactive

[![Build Status](https://travis-ci.org/gal-orlanczyk/go-reactive.svg?branch=develop)](https://travis-ci.org/gal-orlanczyk/go-reactive)
[![Version](https://img.shields.io/cocoapods/v/GoReactive.svg?style=flat)](https://cocoapods.org/pods/GoReactive)
[![License](https://img.shields.io/cocoapods/l/GoReactive.svg?style=flat)](https://cocoapods.org/pods/GoReactive)
[![Platform](https://img.shields.io/cocoapods/p/GoReactive.svg?style=flat)](https://cocoapods.org/pods/GoReactive)

GoReactive is a simple yet powerful reactive framework based on observable pattern.
It provides easy way to acheive many simple tasks like observing, binding and more.
Should be useful for many day to day tasks without adding too much complexity into the codebase.

GoReactive doesn't handle events in different threads intentionly, the main point of this framework is to provide great functionality that is easily debugable and lightweight.

The reason for developing this framework is that in some places marrying with a big reactive framework can be difficult to maintain, harder for new hires to keep up (steep learning curve) and without the danger of having mistakes or misuse.
This framework aims to provide a simple solution for most used flows and observing without having to debug multithreaded enviorments, without needing to learn many operators and changing your app architecture. just use where needed without interrupting the app flo and current architecture.

This framework will not get much bigger and have many operators if you need something more complex this is not for you, if you want just simple bindings and observable pattern this framework can be a great candidate.

[Documentation](https://gal-orlanczyk.github.io/go-reactive)

## Simple Usage

```swift

import GoReactive

...

class ViewModel {
    let bindableProperty = Property<String?>(nil)
}

...

let viewModel = ViewModel()
// A group of cancelable subscriptions, 
// will handle disposing of all subscriptions when deinitialized.
let cancelableGroup = CancelableGroup()

@IBOutlet weak var bindableLabel: UILabel!
@IBOutlet weak var bindableTextField: UITextField!

...

// Can subscribe to changes
self.viewModel.bindableProperty.subscribe(onNext: { (value) in
    // handles subscription
}).add(to: self.cancelableGroup)

// Can bind one way
self.viewModel.bindableProperty
    .bind(to: self.bindableLabel.reactiveComponent.text)
    .add(to: self.cancelableGroup)

// Can bind two way
self.bindableTextField.reactiveComponent.text
    .bidirectionalBind(to: self.viewModel.bindableProperty)
    .add(to: self.cancelableGroup)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Xcode 10
* Swift 4.2

## Installation

GoReactive is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GoReactive'
```

## TODO

* [ ] Combine observables operation
* [ ] Map observable operation
* [ ] Use KVO, notifications etc. with observable sequence
* [ ] CI Pipeline for auto-deploy (version and docs on tags) and other improvements
* [ ] Code coverage
* [ ] SwiftLint
* [ ] tvOS, macOS support

## Author

Gal Orlanczyk, gal.orlanczyk@outlook.com

## License

GoReactive is available under the MIT license. See the LICENSE file for more info.
