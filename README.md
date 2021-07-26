# ReactNativeAxaMobileSdk
**React Native Axa Mobile Sdk** is a modern, well-supported, and cross-platform SDK for App Experience Analytics. This SDK provides deep insights into the performance, user experience, crash, and log analytics of your applications.

CA App Experience Analytic native SDK's react native supplement for using custom metrics.

## Platforms Supported

- [x] iOS
- [x] Android

## Getting started
[DX App Experience Analytics](https://www.broadcom.com/info/aiops/app-analytics)

Check out our [DX App Experience Analytics documentation](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/app-experience-analytics-saas/SaaS/reference/data-collected-by-ca-app-experience-analytics-sdk.html). You'll find more information about what the App Experience Analytics SDK collects from your app.

## Requirements
- [x] iOS
    1. Xcode 11 or higher
    2. iOS 8.0 or higher
- [x] Android

## Installation

Follow these steps to integrate the `react native axa mobile sdk` into your project.

### Automatic installation
1. Run **one** of these commands from your React Native project directory:

    `$ yarn add react-native-axa-mobile-sdk`
    
    or
    
    `$ npm install react-native-axa-mobile-sdk --save`
2. Run this command command for automatic linking:

    `$ react-native link react-native-axa-mobile-sdk`
3. iOS Setup 
    * Podfile update
    
    If you're already using Cocoapods, go to the `ios` folder from your project and specify the pod below on a single line inside your target block in a Podfile:
       
```
       pod 'react-native-axa-mobile-sdk', path: '../node_modules/react-native-axa-mobile-sdk'
```
        
    Then, run this command using the command prompt from the `ios` folder of your project:

```
        pod install
```
    
    * Drag & Drop the downloaded `xxx_camdo.plist` file into the Supporting files.


### Manual installation


<details>
<summary>iOS</summary>

1. In XCode, in the project navigator, right-click `Libraries` ➜ `Add Files to [your project's name]`.
2. Go to `node_modules` ➜ `react-native-axa-mobile-sdk` and add `ReactNativeAxaMobileSdk.xcodeproj`.
3. In XCode, in the project navigator, select your project. 
4. Add `libReactNativeAxaMobileSdk.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`.
5. Run your project (`Cmd+R`)<
6. Update the Podfile.

    If you're already using Cocoapods, goto `ios` folder from your project. Specify the pod below on a single line inside your target block in a Podfile:
   
```
   pod 'react-native-axa-mobile-sdk', path: '../node_modules/react-native-axa-mobile-sdk'
```

Then, run this command using the command prompt from the `ios` folder of your project:

```
    pod install
```

7. Drag & drop the downloaded `xxx_camdo.plist` file into the Supporting files.
</details>


<details>
<summary>Android</summary>

1. Open up `android/app/src/main/java/[...]/MainActivity.java`.
  - Add `import com.reactlibrary.ReactNativeAxaMobileSdkPackage;` to the imports at the top of the file.
  - Add `new ReactNativeAxaMobileSdkPackage()` to the list returned by the `getPackages()` method.
2. Append this lines to `android/settings.gradle`:
```
      include ':react-native-axa-mobile-sdk'
      project(':react-native-axa-mobile-sdk').projectDir = new File(rootProject.projectDir,     '../node_modules/react-native-axa-mobile-sdk/android')
```
3. Insert this line inside the dependencies block in `android/app/build.gradle`:
```
      compile project(':react-native-test-sdk')
```
</details>


## Initialising the SDK in your Source code
<details>
<summary>iOS</summary>

### Objective C

1. Add the import header `#import "CAMDOReporter.h"` to your AppDelegate.m file.

2. Initialize the CAMobileAppAnalytics SDK in the `didFinishLaunchingWithOptions:` method.

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
3. Add the `<app_name>-Bridging-header.h` file to the Swift Compiler - Code Generation section
in the Build Settings.
`<name of the project>/<app_name>-Bridging-header.h`
4. Initialize the CAMobileAppAnalytics sdk in the `didFinishLaunchingWithOptions` method.
``` 
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //Initialize CA App Experience Analytics SDK
    CAMDOReporter.initializeSDK(options: SDKOptions.SDKLogLevelVerbose) { (completed, error) in
        
    }
    return true
}
```
5. Save and re-build your project.

</details>

## Updation

Follow these steps to updgrade the `react native axa mobile sdk` in your project.

1. Run **one** of these command from your React Native project directory:

    `$ yarn upgrade react-native-axa-mobile-sdk`
    
    or
    
    `$ npm update react-native-axa-mobile-sdk --save`

2. Run the `$ pod update` command from the `ios` folder.


## Usage
```javascript
import ReactNativeAxaMobileSdk from 'react-native-axa-mobile-sdk';

**CARL**// TODO: What to do with the module?
ReactNativeAxaMobileSdk;

**CARL** ???
const AXASDK = NativeModules.ReactNativeAxaMobileSdk;

**CARL** TODO: Find the proper method to assign a variable to use ReactNativeAxaMobileSdk from the package.
In my testing, the above line still works but seems awkward.
```
  
## APIs
Individual APIs interact with the SDK to perform specific tasks and reading or setting information. All APIs are asynchronous, and returning information is achieved using a callback or completion block. You can find specifics in the React Native documentation for [Android](https://reactnative.dev/docs/native-modules-android#callbacks) or [iOS](https://reactnative.dev/docs/native-modules-ios#callbacks) callbacks.

A callback returns one value or more.

A completionBlock always returns 2 values: completed: a Boolean and errorString: an string value).

Once you have assigned a variable or constant to the ReactNativeAxaMobileSdk module as shown in "Usage", use these commands to call individual APIs:

```
AXASDK.individualAPI();
AXASDK.individualAPI(argument1, argument2, ...);
AXASDK.individualAPI(argument1, ..., callback);
AXASDK.individualAPI(argument1, argument2, ..., completionBlock);

```

Follow the examples in the API descriptions below for how to use the callback or completion blocks.

### disableSDK()
<details><summary>Use this API to disable the SDK.</summary>

When the SDK is disabled, the SDK no longer tracks application or user interactions.

```
AXASDK.disableSDK();

```
</details>


### enableSDK()
<details><summary>Use this API to enable the SDK.</summary>

The SDK is enabled by default. You need to call this API only if you called disableSDK earlier.

```
AXASDK.enableSDK();

```
</details>

### isSDKEnabled( callback )
<details><summary>Use this API to determine whether the SDK is enabled or not.</summary>

Parameters:
-  callback is a function that expects a Boolean value.

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


### getDeviceId( callback )
<details><summary>Use this API to get the unique device ID generated by the SDK.</summary>

Parameters:
-  callback is a function that expects a string value.

```
AXASDK.getDeviceId((deviceId) => {
    if (deviceId) {
        console.log(`received device id: ${deviceId}`);
    }
})

```
</details>


### getCustomerId( callback )
<details><summary>Use this API to get the customer ID for this session.</summary>

Parameters:
-  callback is a function that expects a string value.

When the customer ID is not set, this API returns an empty string.

```
AXASDK.getCustomerId((customerId) => {
    if (customerId) {
        console.log(`received customer id: ${customerId}`);
    }
})

```
</details>


### setCustomerId( customerId, callback )
<details><summary>Use this API to set the customer ID for this session.</summary>

Parameters:
- customerID is a string containing the customer ID.
- callback is a function that expects an (SDKError value).

When an empty string is passed, the customer ID is reset. An SDKError value is returned.

```
var customerId = "New Customer"

AXASDK.setCustomerId(customerId, (SDKError) => {
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
<details><summary>Use this API to set a custom session attribute.</summary>

Parameters:
- name is a string containing the name of the attribute.
- value is a string containing the value for the attribute.
- callback is a function that expects an (SDKError value).

When an empty string is passed, the customer ID is reset. An SDKError value is returned.

```
var attributeName = "ClientDemo";
var attributeValue = "NewFeatures";

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
<details><summary>Use this API to stop collecting potentially sensitive data.</summary>

This data is not collected when the app enters a private zone:
- Screenshots
- Location information, including GPS and IP addresses.
- Values in any text-entry fields.

The SDK is enabled by default.  You need to call this API only if you called disableSDK earlier.

```
AXASDK.enterPrivateZone();

```
</details>


### exitPrivateZone()
<details>
<summary>Use this API to start collecting all data again.</summary>

```
AXASDK.exitPrivateZone();

```
</details>


### isInPrivateZone( callback )
<details>
<summary>Use this API to determine whether the SDK is in a private zone.</summary>

Parameters:
- callback is a function that expects a Boolean value.

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


### getAPMHeader( callback )
<details>
<summary>Use this API to get the SDK-computed DX APM header in key-value format.</summary>

Parameters:
-  callback is a function that expects an array of alternating key/value pairs.
-  callback is a function that expects a dictionary or map of key/value pairs.


```
AXASDK.getAPMHeader((headers) => {
    if (headers) {
        console.log(`received apm headers: ${headers}`);
        // TOTO: show how to access values in this dictionary
    }
})

```
</details>


### addToAPMHeader( data )
<details>
<summary>Use this API to add custom data to the SDK-computed DX APM header.</summary>

Parameters:
-  data is a non-empty string in the form of "key=value".

-  data is appended to the header separated by a semicolon (;).

```
var newAPMData = "PrivateKey=PrivateInfo";

AXASDK.addToAPMHeader(newAPMData);

```
</details>


### setNSURLSessionDelegate( delegate )
<details>
<summary>Use this API to set your delegate instance to handle authorization challenges.</summary>

Use this API when using the SDKUseNetworkProtocolSwizzling option during SDK initialization.

Parameters:
-  delegate an object or module that responds to NSURLSessionDelegate protocols.

```
AXASDK.setNSURLSessionDelegate(delegate);

```
</details>


### setSSLPinningMode( pinningMode, pinnedValues )
<details>
<summary>Use this API to set the SSL-pinning mode and array of pinned values.</summary>

Parameters:
- pinningMode is one of the CAMDOSSLPinning modes described below.
- pinnedValues is an array that is required by the pinning mode.

```
var pinningMode = CAMDOSSLPinningModeFingerPrintSHA1Signature;
var pinnedValues = [--array of SHA1 fingerprint values--];

AXASDK.setSSLPinningMode(pinningMode, pinnedValues);
          
```
```
Supported pinning modes:
- CAMDOSSLPinningModePublicKey OR CAMDOSSLPinningModeCertificate
        - array of certificate data (NSData from SeccertificateRef)
        - or, certificate files(.cer) to be present in the resource bundle
- CAMDOSSLPinningModeFingerPrintSHA1Signature
        - array of SHA1 fingerprint values
- CAMDOSSLPinningModePublicKeyHash
        - array of PublicKeyHashValues
```
</details>


### stopCurrentSession()
<details>
<summary>Use this API to stop the current session.</summary>

No data is logged until the SDK calls the startSession API.

```
AXASDK.stopCurrentSession();

```
</details>


### startNewSession()
<details>
<summary>Use this API to start a new session.</summary>

A session already in progress is stopped, and new session is started.

```
AXASDK.startNewSession();

```
</details>


### stopCurrentAndStartNewSession()
<details>
<summary>Convenience API to stop the current session while in-progress, and start a new session.</summary>

This API is equivalent to calling stopCurrentSession() followed by startNewSession()

```
AXASDK.stopCurrentAndStartNewSession();

```
</details>


### startApplicationTransaction( transactionName, serviceName, completionBlock )
<details>
<summary>Use this API to start a transaction with a name.</summary>

Parameters:
- transactionName is a string indicating the transaction being processed.
- serviceName is a string indicating the service or application being applied.
- completionBlock is a function expecting a BOOL completed and an errorString.

Successful execution of the method completes as YES. The errorString is an empty string.
In case of failure, execution of the method completes as NO. The errorString contains a message that includes a domain, code, and localizedDescription.

```
var transactionName = "subscription";
var serviceName = "MyApp"";

AXASDK.startApplicationTransaction(transactionName, serviceName (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***transaction started (${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error: ${errorString}`)
        }
    }
})

```
</details>


### stopApplicationTransaction( transactionName, completionBlock )
<details>
<summary>Use this API to stop a transaction that has a specific name.</summary>

Parameters:
- transactionName is a string.
- completionBlock is a function expecting a BOOL completed and an errorString.

Successful execution of the method completes as YES. The errorString is an empty string.
case of failure, execution of the method completes as NO. The errorString contains a message that includes a domain, code, and localizedDescription.

```
var transactionName = "subscription";

AXASDK.stopApplicationTransactionWithName(transactionName, (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***transaction stopped (${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error stopping transaction: ${errorString}`)
        }
    }
})

```
</details>

### stopApplicationTransactionWithFailure( transactionName, failureString, completionBlock )
<details>
<summary>Use this API to stop a transaction that has a specific name.</summary>

Parameters:
- transactionName is a string to indicate the transaction being processed.
- failureString is a string to indicate the name, message or type of failure.
- completionBlock is a function expecting a BOOL completed, and an errorString.

Successful execution of the method completes as YES. The errorString is an empty string.
case of failure, execution of the method completes as NO. The errorString contains a message that includes a domain, code, and localizedDescription.

```
var transactionName = "subscription";
var failureString = "Mismatched Arguments";

AXASDK.stopApplicationTransactionWithFailure(transactionName, failureString, (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***transaction stopped with failure: (${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error stopping transaction: ${errorString}`)
        }
    }
})

```
</details>



### setCustomerFeedback( feedback )
<details>
<summary>Use this API to provide feedback from the user after a crash.</summary>

Parameters:
-  feedback is a string containing any customer feedback for the crash.

```
var feedback = "something interesting happened";
AXASDK.setCustomerFeedback(feedback);

```
</details>


### setLocation( latitude, longitude )
<details>
<summary>Use this API to set the customer geographic or GPS location.</summary>

Parameters:
- latitude is a double with the geographic latitude from -90,0 to 90.0 degrees.
- longitude is a double with the geographic longitude from -180.0 to 180.0 degrees.

```
var latitude = 34.678;
var longitude = -122.456;
AXASDK.setLocation(latitude, longitude);

```
</details>


### setCustomerLocation( postalCode, countryCode )
<details>
<summary>Use this API to set customer/user location.</summary>

Parameters:
- postalCode is a string with the postal code. For example, a zip code in the United States.
- countryCode is a string with the two letter international country code.

```
var postalCode = "95200";
var countryCode = "US";
AXASDK.setCustomerLocation(postalCode, countryCode);

```
</details>


### enableScreenShots( captureScreen )
<details>
<summary>Use this API to programmatically enable or disable automatic screenshot capturing.</summary>

Parameters:
-  captureScreen is a Boolean value to enable/disable automatic screen captures.

Normally the policy determines whether automatic screen captures are performed.
Use this API to override the policy, or the current setting of this flag.

```
AXASDK.enableScreenShots(true);
  or
AXASDK.enableScreenShots(false);

```
</details>


### viewLoaded( viewName, loadTime, captureScreen, completionBlock )
<details>
<summary>Use this API to create a custom app flow with dynamic views.</summary>

Parameters:
- viewName is the name of the loaded view.
- loadTime is the time it took the API to load the view.
- captureScreen is a Boolean value. When false, screen capture is disabled for the current invocation of the API call.
- completionBlock is a function that expects a BOOL completed and an errorString.

The value captureScreen, can allow (when true) or disable (when false), screen capture for the current call.
The value may not be used to enable screen capture when screen capture is not already enabled by current policy.

Successful execution of the method completes as YES. The errorString is an empty string.
case of failure, execution of the method completes as NO. The errorString contains a message that includes a domain, code, and localizedDescription.

```
var viewName = "my custom view";"
var loadTime = 237;
var captureScreen = false

AXASDK.viewLoaded(viewName, loadTime, captureScreen, (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***view load recorded (${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error recording  view load: ${errorString}`)
        }
    }
})

```
</details>


### ignoreView( viewName )
<details>
<summary>Use this API to set the name of a view to be ignored.</summary>

Parameters:
-  viewName is the name of the view to be ignored.

Screenshots and transitions of the views that are in ignore list are not captured.
If more than one view is to be ignored, you can call ignoreViews() with a list.

```
var viewName = "view1";

AXASDK.ignoreView(viewName);

```
</details>


### ignoreViews( viewNames )
<details>
<summary>Use this API to provide a list of view names to be ignored.</summary>

Parameters:
-  viewNames is a list (an array) of the view names of the  to be ignored.

The API does not capture screenshots and transitions of the views that are in the ignore list.
If only a single view name to be ignored, you can call ignoreView() with the view name.

```
var viewNames = ["view1", "view2", ..., "viewN"];

AXASDK.ignoreViews(viewNames);

```
</details>


### isScreenshotPolicyEnabled( callback )
<details>
<summary>Use this API to determine wheter automatic screenshots are enabled by policy.</summary>

Parameters:
-  callback is a function that expects a Boolean value.

Returns YES when screenshots are enabled by policy.

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
<details>
<summary>Use this API to add a custom network event in the current session.</summary>

Parameters:
- url is a string reprentation of the network URL to be logged.
- status is an integer value indicating the status, for example 200, 404, and so on.
- responseTime is an integer value representing the response time.
- inBytes is an integer value representing the number of bytes input.
- outBytes is an integer value representing the number of bytes output.
- completionBlock is a function expecting a BOOL completed, and an errorString.

Successful execution of the method will have completed as YES and errorString as an empty string.
In case of failure completed is set to NO and errorString contains a message with a domain, code and localizedDescription.

```
var url = "https://myserver/specific_content/";"
var status = "OK";"
var responseTime = 234;
var inBytes = 864200;
var outBytes = 6236;

AXASDK.logNetworkEvent( url, status, responseTime, inBytes, outBytes, (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***network event logged (${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error logging network event: ${errorString}`)
        }
    }
})

```
</details>


### logTextMetric( metricName, metricValue, attributes, completionBlock )
<details>
<summary>Use this API to add a custom text event in the current session.</summary>

Parameters:
- metricName is a string metric name.
- metricValue is a string metric value.
- attributes is a dictionary that you can use to send any extra parameters.
- completionBlock is a function expecting a BOOL completed, and an errorString.

Successful execution of the method completes as YES. The errorString is an empty string.
In case of failure, execution of the method completes as NO. The errorString contains a message that includes a domain, code, and localizedDescription.

```
var metricName = "ImageName";
var metricValue = "Pretty Picture";
var attributes = null;

AXASDK.logTextMetric( metricName, metricValue, attributes, (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***text metric logged (${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error logging text metric: ${errorString}`)
        }
    }
})

```
</details>


### logNumericMetric( metricName, metricValue, attributes, completionBlock )
<details>
<summary>Use this API to add a custom network event in the current session.</summary>

Parameters:
- metricName is a string metric name.
- metricValue is a string metric value.
- attributes is a dictionary that you can use to send any extra parameters
- completionBlock is a function expecting a BOOL completed, and an errorString

Successful execution of the method completes as YES. The errorString is an empty string.
In case of failure, execution of the method completes as NO. The errorString contains a message that includes a domain, code, and localizedDescription.

```
var metricName = "ImageWidth";
var metricValue = 1080;
var attributes = null;

AXASDK.logTextMetric( metricName, metricValue, attributes, (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***numeric metric logged(${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error logging numeric metric: ${errorString}`)
        }
    }
})

```
</details>


### sendScreenShot( screenName, imageQuality, completionBlock )
<details>
<summary>Use this API to stop a transaction that has a specific name.</summary>

Parameters:
- screenName is a non-empty string for the screen name.
- imageQuality is number indicating the quality of the image between 0.0 and 1.0. The default is low-quality.
- completionBlock is a function expecting a BOOL completed, and an errorString.

Successful execution of the method completes as YES. The errorString is an empty string.
In case of failure, execution of the method completes as NO. The errorString contains a message that includes a domain, code, and localizedDescription.

```
var screenName = "My custom Screen";
var imageQuality = CAMAA_SCREENSHOT_QUALITY_MEDIUM;

AXASDK.sendScreenShot(screenName, imageQuality, (completed, errorString) => {
    if (completed) {
        // everything is fine
        console.log(`***screen shot sent (${completed}) ${errorString}`);
    } else {
        if (errorString) {
            // process error message
            console.log(`error sending screen shot: ${errorString}`)
        }
    }
})

```

Here are the defined values for quality :
- CAMAA_SCREENSHOT_QUALITY_HIGH
- CAMAA_SCREENSHOT_QUALITY_MEDIUM
- CAMAA_SCREENSHOT_QUALITY_LOW
- CAMAA_SCREENSHOT_QUALITY_DEFAULT

</details>


### uploadEvents( callback )
<details>
<summary>Use this API to force an upload event.</summary>

An upload event sends all the information that the API collected since any previous upload event to the DX APM servers.

Parameters:
- callback is a function that expects a response object and an ErrorString.

Response is a key/value paired object which contains:
- the Key 'CAMDOResponseKey' holds any URLResponse information.
- the key 'CAMDOTotalUploadedEvents' holds the total number of events uploaded.

ErrorString is empty when the API call is completed. Otherwise, the ErrorString value is a localized error-description.
```
AXASDK.uploadEvents((response, errorString) => {ErrorString
    if (errorString) {
        // process error message
        console.log(`error: ${errorString}`)
    } else {
        var events=response.CAMDOTotalUploadedEvents;
        var key=response.CAMDOResponseKey;
        console.log(`***uploaded ${events} events (key:${key})`);
    }
})

```
</details>


