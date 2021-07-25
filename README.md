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

### Automatic installation
1. Run the following command from your React Native project directory

    `$ yarn add react-native-axa-mobile-sdk`
    
    or
    
    `$ npm install react-native-axa-mobile-sdk --save`
2. Run the following command for automatic linking

    `$ react-native link react-native-axa-mobile-sdk`
3. iOS Setup 
    * Podfile update
    
    If you're already using Cocoapods, goto `ios` folder from your project and specify the below pod on a single line inside your target block in a Podfile
       
```
       pod 'react-native-axa-mobile-sdk', path: '../node_modules/react-native-axa-mobile-sdk'
```
        
    Then, run the following command using the command prompt from the `ios` folder of your project

```
        pod install
```
    
    * Drag & Drop the downloaded `xxx_camdo.plist` file into the Supporting files


### Manual installation


<details>
<summary>iOS</summary>

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-axa-mobile-sdk` and add `ReactNativeAxaMobileSdk.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libReactNativeAxaMobileSdk.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

5. Podfile update

    If you're already using Cocoapods, goto `ios` folder from your project and specify the below pod on a single line inside your target block in a Podfile
   
```
   pod 'react-native-axa-mobile-sdk', path: '../node_modules/react-native-axa-mobile-sdk'
```
    
    Then, run the following command using the command prompt from the `ios` folder of your project

```
    pod install
```

6. Drag & Drop the downloaded `xxx_camdo.plist` file into the Supporting files
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

## Updation

Follow these steps to updgrade the `react native axa mobile sdk` in your project

1. Run the following command from your React Native project directory

    `$ yarn upgrade react-native-axa-mobile-sdk`
    
    or
    
    `$ npm update react-native-axa-mobile-sdk --save`

2. Run `$ pod update` command from the `ios` folder.


## Usage
```javascript
import ReactNativeAxaMobileSdk from 'react-native-axa-mobile-sdk';

// TODO: What to do with the module?
ReactNativeAxaMobileSdk;

???
const AXASDK = ReactNativeAxaMobileSdk;
  or
const AXASDK = NativeModules.ReactNativeAxaMobileSdk;
```
  
  
## APIs
Individual APIs interact with the SDK to perform specific tasks and reading or setting information.  All APIs are asynchronous, and returning information is achieved using a callback or completion block.  The specifics can be found in the React Native documentation for [Android](https://reactnative.dev/docs/native-modules-android#callbacks) or [iOS](https://reactnative.dev/docs/native-modules-ios#callbacks) callbacks.

A callback returns one or more value.

A completionBlock always returns 2 values: (completed: a boolean) and (error: an NSError value).

Once you have assigned a variable or constant to the ReactNativeAxaMobileSdk module as shown in "Usage", calling individual APIs is as simple as:

```
AXASDK.individualAPI();
AXASDK.individualAPI(argument1, argument2, ...);
AXASDK.individualAPI(argument1, ..., callback);
AXASDK.individualAPI(argument1, argument2, ..., completionBlock);

```

Follow the examples in the API descriptions below for how to use the callback or completion blocks.


### disableSDK()
Use this API to disable the SDK.
<details>
<summary>more...</summary>

When disabled, the SDK no longer does any tracking of the application, or user interaction.

```
AXASDK.disableSDK();

```
</details>


### enableSDK()
<details>
<summary>Use this API to enable the SDK.
</summary>
Use this API to enable the SDK.

The SDK is enabled by default.  You need to call this API only if you called disableSDK earlier.

```
AXASDK.enableSDK();

```
</details>


### isSDKEnabled( callback )
<details>
<summary>Use this API to determine if the SDK is enabled or not.</summary>
Use this API to determine if the SDK is enabled or not.

Parameters:
-  callback is a function which expects a boolean value

```
AXASDK.isSDKEnabled((isEnabled) => {
    if (isEnabled) {
        // enabled action
    } else {
        // non-enabled action
    }
    console.log(`SDK is enabled: ${isEnabled}`);
})

```
</details>


### deviceId( callback )
<details>
<summary>Use this API to get the unique device ID generated by the SDK.</summary>
Use this API to get the unique device ID generated by the SDK.

Parameters:
-  callback is a function which expects a string value.

```
AXASDK.deviceId((deviceId) => {
    if (deviceId) {
        console.log(`received device id: ${deviceId}`);
    }
})

```
</details>


### customerId( callback )
Use this API to get the customer ID for this session.
<details>
<summary>more...</summary>

Parameters:
-  callback is a function which expects a string value

If the customer Id is not set, this API returns an empty string.

```
AXASDK.customerId((customerId) => {
    if (customerId) {
        console.log(`received customer id: ${customerId}`);
    }
})

```
</details>


### setCustomerId( customerId, callback )
Use this API to set the customer ID for this session.
<details>
<summary>more...</summary>

Parameters:
- customerID is a string containing the customer Id
- callback is a function which expects an (SDKError value)

If an empty string is passed, the customer id is reset. An SDKError value is returned.

```
AXASDK.setCustomerId("CustomerID", (SDKError) => {
    switch (SDKError) {
      case ErrorNone:
        console.log(`CustomerId set successfully.`);
        break;
      case ErrorNoTransactionName:
      case ErrorTransactionInProgress:
      case ErrorFailedToTakeScreenshot:
      case ErrorInvalidValuesPassed:
      default:
        console.log(`Error setting customer Id: ${SDKError}`);
    }
})

```

#### SDKError Values
-   ErrorNone
-   ErrorNoTransactionName
-   ErrorTransactionInProgress
-   ErrorFailedToTakeScreenshot
-   ErrorInvalidValuesPassed

</details>


### setSessionAttribute( name, value, callback )
Use this API to set a custom session attribute.
<details>
<summary>more...</summary>

Parameters:
-  name is a string containing the name of the attribute
- value is a string containing the value for the attribute
- callback is a function which expects an (SDKError value)

If an empty string is passed, the customer id is reset. An SDKError value is returned.

```
AXASDK.setSessionAttribute(attributeName, attributeValue, (SDKError) => {
    switch (SDKError) {
      case ErrorNone:
        console.log(`Session attribute set successfully.`);
        break;
      case ErrorNoTransactionName:
      case ErrorTransactionInProgress:
      case ErrorFailedToTakeScreenshot:
      case ErrorInvalidValuesPassed:
      default:
        console.log(`Error setting session attribute: SDKError:${SDKError}`);
    }
})

```

#### SDKError Values
-   ErrorNone
-   ErrorNoTransactionName
-   ErrorTransactionInProgress
-   ErrorFailedToTakeScreenshot
-   ErrorInvalidValuesPassed

</details>


### enterPrivateZone()
Use this API to stop collecting potentially sensitive data.
<details>
<summary>more...</summary>

The following data is not collected when the app enters a private zone:
- Screenshots
- Location information including GPS and IP addresses
- Values in any text entry fields

The SDK is enabled by default.  You need to call this API only if you called disableSDK earlier.

```
AXASDK.enterPrivateZone();

```
</details>


### exitPrivateZone()
Use this API to start collecting all data again.
<details>
<summary>more...</summary>

```
AXASDK.exitPrivateZone();

```
</details>


### isInPrivateZone( callback )
Use this API to determine if the SDK is in a private zone.
<details>
<summary>more...</summary>

Parameters:
- callback is a function which expects a boolean value

```
AXASDK.isInPrivateZone((inPrivateZone) => {
    if (inPrivateZone) {
        // private zone action
    } else {
        // non-private zone action
    }
    console.log(`SDK is in private zone: ${inPrivateZone}`);
})

```
</details>


### apmHeader( callback )
Use this API to get the SDK computed APM header in key value format.
<details>
<summary>more...</summary>

Parameters:
-  callback is a function which expects an (array of alternating key, value pairs)
-  callback is a function which expects a dictionary or map of key, value pairs


```
AXASDK.apmHeader((headers) => {
    if (headers) {
        console.log(`received apm headers: ${headers}`);
        // TOTO: show how to access values in this dictionary
    }
})

```
</details>


### addToApmHeader( data )
Use this API to add custom data to the SDK computed APM header.
<details>
<summary>more...</summary>

Parameters:
-  data is a non-empty string in the form of "key=value".

data will be appended to the header separated by a semicolon (;).

```
var newAPMData = "PrivateKey=PrivateInfo";
AXASDK.addToApmHeader(newAPMData);

```
</details>


### setNSURLSessionDelegate( delegate )


### setSSLPinningMode( pinningMode, pinnedValues )
Use this API to set the ssl pinning mode and array of pinned values.
<details>
<summary>more...</summary>

Parameters:
-  pinningMode is one of the CAMDOSSLPinning modes described below
- pinnedValues is an array as required by the pinning mode

Supported pinning modes:
- CAMDOSSLPinningModePublicKey OR CAMDOSSLPinningModeCertificate
          - array of certificate data (NSData from SeccertificateRef)
          - or, certificate files(.cer) to be present in the resource bundle
- CAMDOSSLPinningModeFingerPrintSHA1Signature
          - array of SHA1 fingerprint values
- CAMDOSSLPinningModePublicKeyHash
          - array of PublicKeyHashValues


```
var pinningMode = CAMDOSSLPinningModeFingerPrintSHA1Signature;
var pinnedValues = [--array of SHA1 fingerprint values--];
AXASDK.setSSLPinningMode(pinningMode, pinnedValues);
          
```
</details>


### stopCurrentSession()
Use this API to stop the current session.
<details>
<summary>more...</summary>

No data will be logged until the startSession API is called again.

```
AXASDK.stopCurrentSession();

```
</details>


### startNewSession()
Use this API to start a new session.
<details>
<summary>more...</summary>

If a session is already in progress, it will be stopped and new session is started.

```
AXASDK.startNewSession();

```
</details>


### stopCurrentAndStartNewSession()
Convenience API to stop the current session in progress and start a new session.
<details>
<summary>more...</summary>

```
AXASDK.stopCurrentAndStartNewSession();

```
</details>


### startApplicationTransactionWithName( transactionName, completionBlock )
Use this API to start a transaction with a name.
<details>
<summary>more...</summary>

Parameters:
- transactionName is a string
-  completionBlock is a standard (BOOL completed, NSError *error) completionBlock

Successful execution of the method will have completed as YES and error object is nil.
In case of failure the completed is set to NO and error will have NSError object with domain,
code and localizedDescription.

```
AXASDK.startApplicationTransactionWithName(transactionName, (completed, error) => {
    if (completed) {
        // everything is fine
        console.log(`***transaction started (${completed}) ${error}`);
    } else {
        if (error) {
            // process error message
            console.log(`error: ${error}`)
        }
    }
})

```
</details>


### stopApplicationTransactionWithName( transactionName, completionBlock )
Use this API to stop a transaction with a specific name.
<details>
<summary>more...</summary>

Parameters:
- transactionName is a string
- completionBlock is a standard (BOOL completed, NSError *error) completionBlock

Successful execution of the method will have completed as YES and error object is nil.
In case of failure the completed is set to NO and error will have NSError object with domain,
code and localizedDescription.

```
AXASDK.stopApplicationTransactionWithName(transactionName, (completed, error) => {
    if (completed) {
        // everything is fine
        console.log(`***transaction stopped (${completed}) ${error}`);
    } else {
        if (error) {
            // process error message
            console.log(`error stopping transaction: ${error}`)
        }
    }
})

```
</details>



### setCustomerFeedback( feedback )
Use this API to provide feedback from the user after a crash.
<details>
<summary>more...</summary>

Parameters:
-  feedback is a string containing any customer feedback for the crash.

```
var feedback = "something interesting happened";
AXASDK.setCustomerFeedback(feedback);

```
</details>


### setCustomerLocation( postalCode, countryCode )
Use this API to set Location of the Customer/User.
<details>
<summary>more...</summary>

Parameters:
- postalCode is a string with the postal code, e.g. zip code in US.
- countryCode is a string with the two letter international code for the country

```
var postalCode = "95200";
var countryCode = "US";
AXASDK.setCustomerLocation(postalCode, countryCode);

```
</details>


### setLocation( latitude, longitude )
Use this API to set Geographic or GPS Location of the Customer.
<details>
<summary>more...</summary>

Parameters:
- latitude is a double with the geographic latitude.
- longitude is a double with the geographic longitude.

```
var latitude = 34.678;
var longitude = -122.456;
AXASDK.setLocation(latitude, longitude);

```
</details>


### sendScreenShot( screenName, imageQuality, completionBlock )
Use this API to stop a transaction with a specific name.
<details>
<summary>more...</summary>

Parameters:
- screenName is a non-empty string for the screen name
- imageQuality is number indicating the quality of the image between 0.0 and 1.0, default is low-quality
- completionBlock is a standard (BOOL completed, NSError *error) completionBlock

Successful execution of the method will have completed as YES and error object is nil.
In case of failure the completed is set to NO and error will have NSError object with domain,
code and localizedDescription.

```
AXASDK.sendScreenShot(screenName, imageQuality, (completed, error) => {
    if (completed) {
        // everything is fine
        console.log(`***screen shot sent (${completed}) ${error}`);
    } else {
        if (error) {
            // process error message
            console.log(`error sending screen shot: ${error}`)
        }
    }
})

```
</details>


### enableScreenShots( captureScreen )
Use this API to programmatically enable or disable capturing screenshots.
<details>
<summary>more...</summary>

Parameters:
-  captureScreen is a boolean value to enable/disable automatic screen captures.

Normally the policy deterines whether automatic screen captures are performed.
Use this API to override the policy, or the current setting of this flag.

```
AXASDK.enableScreenShots(true);
  or
AXASDK.enableScreenShots(false);

```
</details>


### viewLoaded( viewName, loadTime, screenCapture, completionBlock )
Use this API to create a custom app flow with dynamic views.
<details>
<summary>more...</summary>

Parameters:
- viewName is the name of the view loaded
- loadTime is the time it took to load the view
- captureScreen is a boolean value to enable/disable automatic screen captures.
- completionBlock is a standard (BOOL completed, NSError *error) completionBlock

Successful execution of the method will have completed as YES and error object is nil.
In case of failure the completed is set to NO and error will have NSError object with domain,
code and localizedDescription.

```
AXASDK.viewLoaded(viewName, loadTime, captureScreen, (completed, error) => {
    if (completed) {
        // everything is fine
        console.log(`***view load recorded (${completed}) ${error}`);
    } else {
        if (error) {
            // process error message
            console.log(`error recording  view load: ${error}`)
        }
    }
})

```
</details>


### ignoreView( viewName )
Use this API to set the name of a view to be ignored
<details>
<summary>more...</summary>

Parameters:
-  viewName is Name of the view to be ignored.

Screenshots and transitions of the views that are in ignore list are not captured.

```
AXASDK.ignoreView(viewName);

```
</details>


### ignoreViews( viewNames )
Use this API to provide a list of view names to be ignored.
<details>
<summary>more...</summary>

Parameters:
-  viewNames is a list (an Array) of names of the views to be ignored.

Screenshots and transitions of the views that are in ignore list are not captured.

```
AXASDK.ignoreViews(viewNames);

```
</details>


### isScreenshotPolicyEnabled( callback )
Use this API to determine of automatic screenshots are enabled by policy.
<details>
<summary>more...</summary>

Parameters:
-  callback is a function which expects a boolean value

Returns YES if screenshots are enabled by policy.

```
AXASDK.isScreenshotPolicyEnabled((isEnabled) => {
    if (isEnabled) {
         // enabled action
    } else {
        // non-enabled action
    }
    console.log(`Screenshots enabled by policy: ${isEnabled}`);
})

```
</details>


### logNetworkEvent( url, status, responseTime, inBytes, outBytes, completionBlock )
Use this API to add a custom network event in the current session.
<details>
<summary>more...</summary>

Parameters:
- url is a string reprentation of the network URL
- status is an NSInteger value indicating the status
- responseTime is an integer value representing the response time
- inBytes is an integer value representing the number of bytes input
- outBytes is an integer value representing the number of bytes output
- completionBlock is a standard (BOOL completed, NSError *error) completionBlock

Successful execution of the method will have completed as YES and error object is nil.
In case of failure the completed is set to NO and error will have NSError object with domain,
code and localizedDescription.

```
AXASDK.logNetworkEvent( url, status, responseTime, inBytes, outBytes, (completed, error) => {
    if (completed) {
        // everything is fine
        console.log(`***network event logged (${completed}) ${error}`);
    } else {
        if (error) {
            // process error message
            console.log(`error logging network event: ${error}`)
        }
    }
})

```
</details>


### logTextMetric( metricName, metricValue, attributes, completionBlock )
Use this API to add a custom text event in the current session.
<details>
<summary>more...</summary>

Parameters:
- metricName is a string metric name
- metricValue is a string metric value
- attributes is a Dictionary which can be used to send any extra parameters
- completionBlock is a standard (BOOL completed, NSError *error) completionBlock

Successful execution of the method will have completed as YES and error object is nil.
In case of failure the completed is set to NO and error will have NSError object with domain,
code and localizedDescription.

```
var metricName = "ImageName";
var metricValue = "Pretty Picture";

AXASDK.logTextMetric( metricName, metricValue, attributes, (completed, error) => {
    if (completed) {
        // everything is fine
        console.log(`***text metric logged (${completed}) ${error}`);
    } else {
        if (error) {
            // process error message
            console.log(`error logging text metric: ${error}`)
        }
    }
})

```
</details>


### logNumericMetric( metricName, metricValue, attributes, completionBlock )
Use this API to add a custom network event in the current session.

Parameters:
- metricName is a string metric name
- metricValue is a string metric value
- attributes is a Dictionary which can be used to send any extra parameters
- completionBlock is a standard (BOOL completed, NSError *error) completionBlock

Successful execution of the method will have completed as YES and error object is nil.
In case of failure the completed is set to NO and error will have NSError object with domain,
code and localizedDescription.
<details>
<summary>more...</summary>

```
var metricName = "ImageWidth";
var metricValue = 1080;

AXASDK.logTextMetric( metricName, metricValue, attributes, (completed, error) => {
    if (completed) {
        // everything is fine
        console.log(`***numeric metric logged(${completed}) ${error}`);
    } else {
        if (error) {
            // process error message
            console.log(`error logging numeric metric: ${error}`)
        }
    }
})

```
</details>


### uploadEvents( callback )
<details>
<summary>Use this API to force an upload event.</summary>
Use this API to force an upload event.

Parameters:
- transactionName is a string
-  callback is a function which expects a response object and an ErrorString.

Response is a key,value paired object which contains:
- the Key 'CAMDOResponseKey' which holds the URLResponse details
- the key 'CAMDOTotalUploadedEvents' which holds the total number of events uploaded

ErrorString is null if the API call is completed, otherwise an error
```
AXASDK.uploadEvents((response, errorString) => {
    console.log(` {${response}} ${errorString}`);
    if (!error) {
        var events=response.CAMDOTotalUploadedEvents;
        var key=response.CAMDOResponseKey;
        console.log(`***uploaded ${events} events (key:${key})`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error: ${errorString}`)
        }
    }
})

```
</details>











## To use as templates for API blocks -- to be removed

### enableSDK
Use this API to enable the SDK.

The SDK is enabled by default.  You need to call this API only if you called disableSDK earlier.
<details>
<summary>example</summary>

```
AXASDK.enableSDK();

```
</details>


### isSDKEnabled( callback )
Use this API to determine if the SDK is enabled or not.

Parameters:
-  callback is a function which expects a boolean value
<details>
<summary>example</summary>

```
AXASDK.isSDKEnabled((isEnabled) => {
if (isEnabled) {
// enabled action
} else {
// non-enabled action
}
console.log(`SDK is enabled: ${isEnabled}`);
})

```
</details>


### deviceId( callback )
Use this API to get the unique device ID generated by the SDK.

Parameters:
-  callback is a function which expects a string value.
<details>
<summary>example</summary>

```
AXASDK.deviceId((deviceId) => {
if (deviceId) {
console.log(`received device id: ${deviceId}`);
}
})

```
</details>


