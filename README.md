# ReactNativeAxaMobileSdk
**React Native Axa Mobile Sdk** is a modern, well-supported, and cross-platform sdk for App Experience Analytics that provides deep insights into the performance, user experience, crash, and log analytics of apps.

CA App Experience Analytic native SDK's react native supplement for using custom metrics

## Platforms Supported

- [x] iOS
- [x] Android

## Getting started
[DX App Experience Analytics](https://www.broadcom.com/info/aiops/app-analytics)

Check out our [documentation](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/app-experience-analytics-saas/SaaS/reference/data-collected-by-ca-app-experience-analytics-sdk.html) for more information about the features that the App Experience Analytics SDK collects from your app.


## Requirements
- [x] iOS
    1. Xcode 11 or higher
    2. iOS 8.0 or higher
- [x] Android

## Installation

Follow these steps to integrate the `react native axa mobile sdk` in your project

#### Automatic installation
1. Run the following command from your React Native project directory

    `$ yarn add react-native-axa-mobile-sdk`
    
    or
    
    `$ npm install react-native-axa-mobile-sdk --save`
2. Run the following command for automatic linking

    `$ react-native link react-native-axa-mobile-sdk`

#### Manual installation


<details>
<summary>iOS</summary>

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-axa-mobile-sdk` and add `ReactNativeAxaMobileSdk.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libReactNativeAxaMobileSdk.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<
</details>


<details>
<summary>Android</summary>

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.ReactNativeAxaMobileSdkPackage;` to the imports at the top of the file
  - Add `new ReactNativeAxaMobileSdkPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
      ```
      include ':react-native-axa-mobile-sdk'
      project(':react-native-axa-mobile-sdk').projectDir = new File(rootProject.projectDir,     '../node_modules/react-native-axa-mobile-sdk/android')
      ```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
      ```
      compile project(':react-native-test-sdk')
      ```
</details>


3. Drag & Drop the downloaded `xxx_camdo.plist` file into the Supporting files


## Initialising the SDK in your Source code
<details>
<summary>iOS</summary>

### Objective C

1. Add the import header `#import "CAMDOReporter.h"` to your AppDelegate.m file

2. Initialize the CAMobileAppAnalytics sdk in `didFinishLaunchingWithOptions:` method 

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [CAMDOReporter initializeSDKWithOptions:SDKLogLevelVerbose  completionHandler:nil];
    return YES;
}
```
3. Save and re-build your project

### Swift
1. Add a header file with the file name format as `<app_name>-Bridging-header.h`.
2. Add the import header `#import "CAMDOReporter.h"` to your `<app_name>-Bridging-header.h` file. 
3. Add the `<app_name>-Bridging-header.h` file to Swift Compiler - Code Generation section
in the Build Settings.
`<name of the project>/<app_name>-Bridging-header.h`
4. Initialize the CAMobileAppAnalytics sdk in `didFinishLaunchingWithOptions` method 
``` 
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //Initialize CA App Experience Analytics SDK
    CAMDOReporter.initializeSDK(options: SDKOptions.SDKLogLevelVerbose) { (completed, error) in
        
    }
    return true
}
```
5. Save and re-build your project

</details>

## Usage
```javascript
import ReactNativeAxaMobileSdk from 'react-native-axa-mobile-sdk';

// TODO: What to do with the module?
ReactNativeAxaMobileSdk;
```
  

