# DeviceDNA #

The DeviceDNA iOS library allows you to identify devices using the Judopay Genome service

## Getting Started

### Step 1: Initialize DeviceDNA

#### 1. Add DeviceDNA as a dependency

#### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

- You can install CocoaPods with the following command:

```bash
$ gem install cocoapods
```

- Add DeviceDNA to your `Podfile` to integrate it into your Xcode project:

```ruby
source 'https://github.com/CocoaPods/Specs.git'

pod 'DeviceDNA', '~> 0.1'
```

- Then, run the following command:

```bash
$ pod install
```

- Please make sure to always **use the newly generated `.xcworkspace`** file not not the projects `.xcodeproj` file

- In your Xcode environment, go to your `Project Navigator` (blue project icon), select the target that will initialize DeviceDNA and open the tab called `Build Phases`.
- Add a new `Run Script Phase` and drag it above the `Compile Sources` build phase.
- In the shell script, paste the following line:

```bash
sh "${PODS_ROOT}/DeviceDNA/Framework/strip-frameworks-cocoapods.sh"
```

#### 2. Initialize DeviceDNA with your Judo account details:

- Add the following statement to the class where you intend to use DeviceDNA

_swift_
```swift
@import DeviceDNA
```

_obj-c_
```objc
#import <DeviceDNA/DeviceDNA.h>
```

- Create an instance of DeviceDNA

_swift_
```swift
let credentials = Credentials(<YOUR_TOKEN> secret:<YOUR_SECRET>)
let deviceDNA = DeviceDNA(credentials: credentials)
```

_obj-c_
```objc
Credentials *credentials = [[Credentials alloc] initWithToken:<YOUR_TOKEN> secret:<YOUR_SECRET>];
DeviceDNA *deviceDNA = [[DeviceDNA alloc] initWithCredentials:credentials];
```

### Step 2: Identify a device

- Call DeviceDNA to identify the device, this executes a callback providing the discovered device identifier and an error object.

_swift_
```swift
deviceDNA.identifyDevice { (deviceIdentifier, error) in
    //Your provided callback.            
}
```

_obj-c_
```objc
[deviceDNA identifyDevice:^(NSString * _Nullable deviceIdentifier, NSError * _Nullable error) {
    //Your provided callback.    
}];
```

### Step 3: Check the device profile

- Using the device identifier returned in step 2, call to retrieve the device profile

_swift_
```swift
deviceDNA.getDeviceProfile(deviceId) { (device, error) in
    //Your provided callback.  
}
```

_obj-c_
```objc
[deviceDNA getDeviceProfile:deviceId completion:^(NSDictionary<NSString *,id> * _Nullable device, NSError * _Nullable error) {
    //Your provided callback.    
}];
```
--------------------------
### Device signals for server to server fraud prevention
When performing server to server payments using the Judopay API, you may wish to identify the device at the time of payment. To obtain the device signals necessary for fraud prevention, use DeviceDNA to obtain the encrypted signals which will be passed in the ```clientDetails``` JSON field of the request body:

_swift_
```swift
deviceDNA.getDeviceSignals { (device, error) in
    if let device = device as [String : String]? 
        let deviceId = device["deviceIdentifier"];
        let key = device["key"];
        let value = device["value"];
    }
}
```

_obj-c_
```objc
[deviceDNA getDeviceSignals:^(NSDictionary<NSString *,NSString *> * _Nullable device, NSError * _Nullable error) {
    NSString *deviceId = device["deviceIdentifier"];
    NSString *key = device["key"];
    NSString *value = device["value"];
}];
```
