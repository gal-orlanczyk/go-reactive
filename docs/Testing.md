# Testing

When implementing observables we sometimes want to test certain functionality works, to make this easy GoReactive provides `GoReactiveTestCase` which provides a basic functionality for reference counting after every test to make sure we are not leaking any objects.
This class is provided by another dependecy called `GoReactiveTests`.

## Installation

In order to activate tracing reference count a `TRACE_REFERENCE_COUNT` flag should be set in *Other Swift Flags* in both `GoReactive` and `GoReactiveTests`.

### Manual

Go to build settings, search for other swift flags and add `-DTRACE_REFERENCE_COUNT`.

### Cocoapods

Add this script to the podfile at the relevant places

```ruby
# inside the relevant test target
pod 'GoReactiveTests'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'GoReactive' || target.name == 'GoReactiveTests'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_REFERENCE_COUNT']
        end
      end
    end
  end
end
```

## Usage

For usage and implementations please look at the tests target in the example project.