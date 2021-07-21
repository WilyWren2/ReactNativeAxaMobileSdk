/*
 *
 * Copyright (c) 2013-2021 CA Technologies (A Broadcom Company)
 * All rights reserved.
 *
 */

/**
 * iOS Native module bridge, that routes the calls to {@link CAMDOReporter} APIs.
 *
 * The React Native app (from its js files) will call this native module,
 * via the JavaScript Module wrapper ReactNativeAxaMobileSdkJSModule.js, to use the
 * AXA Custom metrics APIs.
 *
 */

#import "ReactNativeAxaMobileSdk.h"
#import <UIKit/UIKit.h>
#import "CAMDOReporter.h"
#import <CoreLocation/CoreLocation.h>
#import <React/RCTConvert.h>

// For custom application version string to be read from bundle (info.plist) use "AXAAppShortVersionString"  as key in info.plist.

/*
 Custom Keys to override AXA SDK behavior , placed in App's Info.plist.
 Key : "AXAAppShortVersionString";   ex : 7.7.2
 Key : "AXACLLocationLevel";   String - one of the values :     "BestForNavigation" ,"NearestTenMeters" , "HundredMeters" ,"Kilometer" ,"ThreeKilometers"
 Key : "AXACollectIp";  Boolean : True/False
 Key : "AXAMaxUploadNetworkCallsLimit";  String  : 1 - 10
 Key : "AXADisabledInterceptors";  Array : NSURLConnection ,NSURLSession ,UIActivityIndicatorView ,UIApplication , WKWebView , Gestures , Touch ; Note : Including UIApplication disables SDK.
 Key : "AXANavigationThrottle" ; String - 1000 , time in milliseconds to throttle navigation collection;
 Key : "AXAActiveSessionTimeOut" ; String, time in milliseconds to stop and start the new session when your app is a continuously active state
 */

#pragma mark - Enum Values

// Enums for SDK Initialization Options
@implementation RCTConvert (SDKOptionsExtensions)
RCT_ENUM_CONVERTER(SDKOptions,
    (@{ @"SDKDefault"                       : @0,
        @"SDKLogLevelSilent"                : @(1 << 0),
        @"SDKLogLevelVerbose"               : @(1 << 1),
        @"SDKCheckProfileOnRestartOnly"     : @(1 << 2),
        @"SDKUseNetworkProtocolSwizzling"   : @(1 << 3), // By default we use NSURLConnection and NSURLSession delegates
        // to observe Network traffic.  This option adds the protocol
        // support if our delegates miss anything
        @"SDKNoNetworkSwizzling"            : @(1 << 4),
        @"SDKNoWorkLightSwizzling"          : @(1 << 5),
        @"SDKNoGeoLocationCapturing"        : @(1 << 6),
        @"SDKCollectDeviceName"             : @(1 << 7), // It is App developer's responsibility to provide a disclaimer to
        // the consumer that they are collecting this data.
        // By default CA SDK will NOT collect the device name
        @"SDKUIWebViewDelegate"             : @(1 << 8), // requires SDK build with private APIs
        @"SDKFixedViewTitles"               : @(1 << 9),
        @"SDKNoCrashReporting"              : @(1 << 10)
     }),
    SDKDefault, integerValue)
@end

// Enums for SDK Errors
@implementation RCTConvert (SDKErrorExtension)
RCT_ENUM_CONVERTER(SDKError,
    (@{ @"ErrorNone"                        : @(ErrorNone),
        @"ErrorNoTransactionName"           : @(ErrorNoTransactionName),
        @"ErrorTransactionInProgress"       : @(ErrorTransactionInProgress),
        @"ErrorFailedToTakeScreenshot"      : @(ErrorFailedToTakeScreenshot),
        @"ErrorInvalidValuesPassed"         : @(ErrorInvalidValuesPassed)
     }),
    ErrorNone, integerValue)
@end

//Enums for the pinningMode during the SSL handshake
@implementation RCTConvert (CAMDOSSLPinningModeExtension)
RCT_ENUM_CONVERTER(CAMDOSSLPinningMode,
    (@{ @"CAMDOSSLPinningModeNone"                      : @(CAMDOSSLPinningModeNone),
        @"CAMDOSSLPinningModePublicKey"                 : @(CAMDOSSLPinningModePublicKey),
        @"CAMDOSSLPinningModeCertificate"               : @(CAMDOSSLPinningModeCertificate),
        @"CAMDOSSLPinningModeFingerPrintSHA1Signature"  : @(CAMDOSSLPinningModeFingerPrintSHA1Signature),
        @"CAMDOSSLPinningModePublicKeyHash"             : @(CAMDOSSLPinningModePublicKeyHash)
     }),
    CAMDOSSLPinningModeNone, integerValue)
@end


@implementation ReactNativeAxaMobileSdk

RCT_EXPORT_MODULE()

/* Note: For native iOS all callbacks return an RCTResponseSenderBlock,
 * which is effectively an array of values.
 * Please reference the README.md file for further details.
 */

#pragma mark - React Exports

- (NSDictionary *)constantsToExport
{
  return @{
    @"ErrorNone"                                    : @(ErrorNone),
    @"ErrorNoTransactionName"                       : @(ErrorNoTransactionName),
    @"ErrorTransactionInProgress"                   : @(ErrorTransactionInProgress),
    @"ErrorFailedToTakeScreenshot"                  : @(ErrorFailedToTakeScreenshot),
    @"ErrorInvalidValuesPassed"                     : @(ErrorInvalidValuesPassed),

    @"SDKDefault"                                   : @(SDKDefault),
    @"SDKLogLevelSilent"                            : @(SDKLogLevelSilent),
    @"SDKLogLevelVerbose"                           : @(SDKLogLevelVerbose),
    @"SDKCheckProfileOnRestartOnly"                 : @(SDKCheckProfileOnRestartOnly),
    @"SDKUseNetworkProtocolSwizzling"               : @(SDKUseNetworkProtocolSwizzling),
    @"SDKNoNetworkSwizzling"                        : @(SDKNoNetworkSwizzling),
    @"SDKNoWorkLightSwizzling"                      : @(SDKNoWorkLightSwizzling),
    @"SDKNoGeoLocationCapturing"                    : @(SDKNoGeoLocationCapturing),
    @"SDKCollectDeviceName"                         : @(SDKCollectDeviceName),
    @"SDKUIWebViewDelegate"                         : @(SDKUIWebViewDelegate),
    @"SDKFixedViewTitles"                           : @(SDKFixedViewTitles),
    @"SDKNoCrashReporting"                          : @(SDKNoCrashReporting),

    @"CAMDOSSLPinningModeNone"                      : @(CAMDOSSLPinningModeNone),
    @"CAMDOSSLPinningModePublicKey"                 : @(CAMDOSSLPinningModePublicKey),
    @"CAMDOSSLPinningModeCertificate"               : @(CAMDOSSLPinningModeCertificate),
    @"CAMDOSSLPinningModeFingerPrintSHA1Signature"  : @(CAMDOSSLPinningModeFingerPrintSHA1Signature),
    @"CAMDOSSLPinningModePublicKeyHash"             : @(CAMDOSSLPinningModePublicKeyHash),

    @"CAMAA_SCREENSHOT_QUALITY_HIGH"                : @(CAMAA_SCREENSHOT_QUALITY_HIGH),
    @"CAMAA_SCREENSHOT_QUALITY_MEDIUM"              : @(CAMAA_SCREENSHOT_QUALITY_MEDIUM),
    @"CAMAA_SCREENSHOT_QUALITY_LOW"                 : @(CAMAA_SCREENSHOT_QUALITY_LOW),
    @"CAMAA_SCREENSHOT_QUALITY_DEFAULT"             : @(CAMAA_SCREENSHOT_QUALITY_DEFAULT),

    @"CAMAA_CRASH_OCCURRED"                         : @"CAMAA_CRASH_OCCURRED",
    @"CAMAA_UPLOAD_INITIATED"                       : @"CAMAA_UPLOAD_INITIATED"
  }; //Register for SDK data upload notification. The receiver is notified when SDK uploads the data to the Collector.
};

/**
 * We should also implement + requiresMainQueueSetup to let React Native know
 * if our module needs to be initialized on the main thread.
 * Otherwise we will see a warning that in the future our module may be initialized
 *  on a background thread unless we explicitly opt out with + requiresMainQueueSetup:
 */
+ (BOOL)requiresMainQueueSetup
{
  return YES;  // only do this if our module initialization relies on calling UIKit!
}

#pragma mark - Sample Method Call

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}


#pragma mark - Internal Functions

/**
 * This function is internal and only for passing NSError * items to JS as a string
 */
NSString * CAMAAErrorString(NSError *error) {
  if (!error) {
    return [NSString string].copy;
  }
  return [NSString stringWithFormat:@"Error: %ld Domain: %@, %@",
          (long)error.code, error.domain, error.userInfo].copy;
}

/**
 * This function is internal and only for passing NSDictionary * items to JS as an array
 */
NSArray * CAMAADict2Array(NSDictionary *dict) {
  NSMutableArray *arry = [[NSMutableArray alloc] init];
  for (id key in dict) {
    [arry addObject:key];
    [arry addObject:dict[key]];
  }
  return arry.copy;
}


#pragma mark - APIs

/**
 * Use this API to initialize the APM SDK.
 * This call should be made as early as possible in the application life cycle.
 * Typically, it is made at the beginning of didFinishLaunchingWithOptions in
 * the AppDelegate class
 *
 * @param options of the type SDKOptions.
 * @param configDetails is an array of alternating key,value pairs - from the CAMDO plist
 * @param completionHandler is a function which expects (BOOL completed, String error)
 *
 * Successful execution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and errorString with domain, code and
 * localizedDescription.
 *
 */
RCT_EXPORT_METHOD(initializeSDKWithOptions:(SDKOptions) options configDetails:(NSDictionary *)configDetails completionHandler:(RCTResponseSenderBlock)callback)
{
    [CAMDOReporter initializeSDKWithOptions:options configDetails:configDetails completionHandler:^(BOOL completed, NSError *error) {
      // callback here
      if (callback) {
        callback(@[ @(completed), CAMAAErrorString(error)] );
      }
    }];
}

/**
 * Use this API to initialize the APM SDK.
 * This call should be made as early as possible in the application life cycle.
 * Typically, it is made at the beginning of didFinishLaunchingWithOptions in
 * the AppDelegate class
 *
 * @param options of the type SDKOptions.
 * @param completionHandler is a function which expects (BOOL completed, String error)
 *
 * Successful execution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and errorString with domain, code and
 * localizedDescription.
 *
 */
RCT_EXPORT_METHOD(initializeSDKWithOptions:(SDKOptions) options completionHandler:(RCTResponseSenderBlock) callback)
{
    [CAMDOReporter initializeSDKWithOptions:options completionHandler:^(BOOL completed, NSError *error) {
      // callback here
      if (callback) {
        callback(@[ @(completed), CAMAAErrorString(error)] );
      }
    }];
}

/**
 * Use this API to enable SDK.  SDK is enabled by default
 * You need to call this API only if you called disableSDK earlier
 */
RCT_EXPORT_METHOD(enableSDK)
{
  [CAMDOReporter enableSDK];
}

/**
 * Use this API to disable the SDK.  
 * When disabled, the SDK no longer does any tracking of the application,
 * or user interaction.
 */
RCT_EXPORT_METHOD(disableSDK)
{
  [CAMDOReporter disableSDK];
}

/**
 * Use this API to determine if the SDK is enabled or not.
 * @param callback is a function which expects a boolean value
 * Returns a boolean value.
 */
RCT_EXPORT_METHOD(isSDKEnabled:(RCTResponseSenderBlock)callback)
{
    BOOL isEnabled = [CAMDOReporter isSDKEnabled];
    callback(@[@(isEnabled)]);
}

/**
 * Use this API to get the unique device ID generated by the SDK
 * @param callback is a function which expects an string value
 */
RCT_EXPORT_METHOD(deviceId:(RCTResponseSenderBlock)callback)
{
    NSString *deviceId = [CAMDOReporter deviceId];
    callback(@[deviceId]);
}

/**
 * Get the customer ID.  If it not set, this API returns nil
 * @param callback is a function which expects an string value
 */
RCT_EXPORT_METHOD(customerId:(RCTResponseSenderBlock)callback)
{
    NSString *customerID = [CAMDOReporter customerId];
    callback(@[customerID]);
}

/**
 * Use this API to set the customer ID.
 * @param customerID is a string containing the customer Id
 * @param callback is a function which expects an (SDKError value)
 * If an empty string is passed, the customer id is reset.
 * If there is a callback, an SDKError value is returned.
 *
 */
RCT_EXPORT_METHOD(setCustomerId:(NSString *) customerId callback:(RCTResponseSenderBlock)callback)
{
  SDKError error = [CAMDOReporter setCustomerId:customerId];
  callback(@[@(error)]);
}

/**
 * Use this API to set a custom session attribute.
 * @param name is a non-nil non-empty string containing the attribute name
 * @param value is a non-nil non-empty string containing the attribute value
 * @param callback is a function which expects an (SDKError value)
 *
 */
RCT_EXPORT_METHOD(setSessionAttribute:(NSString *) name withValue:(NSString *)value  callback:(RCTResponseSenderBlock)callback)
{
  SDKError error = [CAMDOReporter setSessionAttribute:name withValue:value];
  callback(@[@(error)]);
}

/**
 * Use this API to stop collecting potentially sensitive data.
 * The following data is not collected when the app enters a private zone
 *    - Screenshots
 *    - Location information including GPS and IP addresses
 *    - Value in the text entry fields
 */
RCT_EXPORT_METHOD(enterPrivateZone)
{
  [CAMDOReporter enterPrivateZone];
}

/**
 * Use this API to start collecting all data again
 */
RCT_EXPORT_METHOD(exitPrivateZone)
{
  [CAMDOReporter exitPrivateZone];
}

/**
 * Use this API to determine if the SDK is in a private zone.
 * @param callback is a function which expects a (boolean value)
 * Returns true/false if CA MAA SDK is in private zone or not
 *
 */
RCT_EXPORT_METHOD(isInPrivateZone:(RCTResponseSenderBlock)callback)
{
    BOOL isInPrivateZone = [CAMDOReporter isInPrivateZone];
    callback(@[@(isInPrivateZone)]);
}

/**
 * Use this API to get the SDK computed APM header in key value format.
 * @param callback is a function which expects an (array of alternating key, value pairs)
 * Returns nil if apm header cannot be computed
 *
 */
RCT_EXPORT_METHOD(apmHeader:(RCTResponseSenderBlock)callback)
{
    NSDictionary *apmHeader = [CAMDOReporter apmHeader];
    callback(@[apmHeader]);
}


/**
 * Use this API to add custom data to the SDK computed APM header.
 * @param data - a non-nil non-empty string in the form of "key=value".
 * data will be appended to the header separated by a semicolon (;).
 *
 */
RCT_EXPORT_METHOD(addToApmHeader:(NSString *)data)
{
  [CAMDOReporter addToApmHeader:data];
}

/* Set your delegate instance to handle auth challenges.  Use it when using SDKUseNetworkProtocolSwizzling option
 */
RCT_EXPORT_METHOD(setNSURLSessionDelegate:(id)delegate)
{
  [CAMDOReporter setNSURLSessionDelegate:delegate];
}


/**
 * Use this API to set the ssl pinning mode and array of pinned values.
 * This method expects array of values depending on the pinningMode
 *
 * Supported pinning modes:
 * CAMDOSSLPinningModePublicKey OR CAMDOSSLPinningModeCertificate
 *          - array of certificate data (NSData from SeccertificateRef)
 *          - or, certificate files(.cer) to be present in the resource bundle
 *
 * CAMDOSSLPinningModeFingerPrintSHA1Signature
 *          - array of SHA1 fingerprint values
 *
 * CAMDOSSLPinningModePublicKeyHash
 *          - array of PublicKeyHashValues
 */
RCT_EXPORT_METHOD(setSSLPinningMode:(CAMDOSSLPinningMode) pinningMode withValues:(NSArray*)pinnedValues)
{
  [CAMDOReporter setSSLPinningMode:pinningMode withValues:pinnedValues];
}

/**
 * Use this API to stop the current session.
 * No data will be logged until the startSession API is called again
 *
 */
RCT_EXPORT_METHOD(stopCurrentSession)
{
    [CAMDOReporter stopCurrentSession];
}

/**
 * Use this API to start a new session.
 * If a session is already in progress, it will be stopped and new session is started
 *
 */
RCT_EXPORT_METHOD(startNewSession)
{
    [CAMDOReporter startNewSession];
}

/**
 * Convenience API to stop the current session in progress and start a new session
 */
RCT_EXPORT_METHOD(stopCurrentAndStartNewSession)
{
    [CAMDOReporter stopCurrentAndStartNewSession];
}


/**
 * Use this API to start a transaction with a name
 * Completion block can be used to verify whether the transaction is started successfully or not
 *
 * @param transactionName is a string
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 *
 * Successful execution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain, 
 * code and localizedDescription.
 *
 */

RCT_EXPORT_METHOD(startApplicationTransactionWithName:(NSString *) transactionName completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter startApplicationTransactionWithName: transactionName completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * Use this API to start a transaction with a name and a service name
 * Completion block can be used to verify whether the transaction is started successfully or not
 *
 * @param transactionName is a string
 * @param serviceName is a string
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 *
 * Successful execution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain, 
 * code and localizedDescription.
 *
 */
RCT_EXPORT_METHOD(startApplicationTransactionWithName:(NSString *) transactionName  service:(NSString *)serviceName completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter startApplicationTransactionWithName: transactionName service: serviceName completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * Use this API to stop a transaction with a specific name 
 * Completion block can be used to verify whether transaction is stopped successfully or not
 *
 * @param transactionName is a string
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 *
 * Successful execution of the method will have completed as YES and and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 *
 */
RCT_EXPORT_METHOD(stopApplicationTransactionWithName:(NSString *) transactionName completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter stopApplicationTransactionWithName: transactionName completionHandler:^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}
/**
 * Use this API to stop a transaction with a specific name, with failure reason
 * Completion block can be used to verify whether transaction is stopped successfully or not
 *
 * @param transactionName is a string
 * @param failure is string.
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 *
 * Successful execution of the method will have completed as YES and and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 *
 */
RCT_EXPORT_METHOD(stopApplicationTransactionWithName:(NSString *) transactionName failure:(NSString *) failure completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter stopApplicationTransactionWithName: transactionName failure:failure completionHandler:^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * Use this API to provide feedback from the user after a crash
 * The App has to register for CAMAA_CRASH_OCCURRED notification
 * and collect the feedback from the user while handling the notification
 *
 */
RCT_EXPORT_METHOD(setCustomerFeedback:(NSString *) feedback)
{
    [CAMDOReporter setCustomerFeedback: feedback];
}

/**
 * Use this API to set Location of the Customer/User
 * by passing postalCode and countryCode.
 *
 */
RCT_EXPORT_METHOD(setCustomerLocation:(NSString *) zip andCountry:(NSString *) country)
{
  [CAMDOReporter setCustomerLocation:zip andCountry:country];
}

/* Set Location of the Customer/User by passing CLLocation (latitude & longitude).
 */
RCT_EXPORT_METHOD(setCustomerLocation:(CLLocation *) location)
{
    [CAMDOReporter setCustomerLocation: location];
}

/**
 * Use this API to send the screen shot of the current screen
 *
 * @param name for the screen name, cannot be nil.
 * @param quality of the image. The value should be between 0.0 and 1.0. The default is low quality.
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 *
 * Successful execution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain, 
 * code and localizedDescription.
 *
 */
RCT_EXPORT_METHOD(sendScreenShot:(NSString *) name withQuality:(CGFloat) quality completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter sendScreenShot: name withQuality: quality completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}


/**
 * Use this API to programmatically enable or disable capturing screenshots.
 * @param captureScreen is a boolean value to enable/disable automatic screen captures.
 * Normally the policy deterines whether automatic screen captures are performed.
 * Use this API to override the policy, or the current setting of this flag.
 *
 */
RCT_EXPORT_METHOD(enableScreenShots:(BOOL) captureScreen)
{
    [CAMDOReporter enableScreenShots: captureScreen];
}

/**
 * This method is to create custom app flow with dynamic views
 * 
 * @param name
 * @param loadTime
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * 
 * Successful execution of the method will have completed as YES and error object is nil 
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(viewLoaded:(NSString *) name loadTime:(CGFloat) loadTime completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter viewLoaded: name loadTime: loadTime completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * This method is to create custom app flow with dynamic views
 * 
 * @param name
 * @param loadTime
 * @param captureScreen is a boolean value to enable/disable screen captures.
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * 
 * Successful execution of the method will have completed as YES and error object is nil 
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(viewLoaded:(NSString *) name loadTime:(CGFloat) loadTime screenShot:(BOOL) screenCapture completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter viewLoaded: name loadTime: loadTime screenShot: screenCapture completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * Use this API to set the name of a view to be ignored
 * @param viewName - Name of the view to be ignored
 * Screenshots and transitions of the views that are in ignore list are not captured
 */
RCT_EXPORT_METHOD(ignoreView:(NSString *) viewName)
{
    [CAMDOReporter ignoreView: viewName];
}

/**
 * Use this API to provide a list of view names to be ignored.
 * @param viewNames - List of names of the views to be ignored.
 * Screenshots and transitions of the views that are in the
 * ignore list are not captured
 *
 */
RCT_EXPORT_METHOD(ignoreViews:(NSSet *) viewNames) 
{
    [CAMDOReporter ignoreViews: viewNames];
}


/**
 * Use this API to determine of automatic screenshots are enabled by policy.
 * @param callback is a function which expects a boolean value
 * Returns YES if screenshots are enabled by policy.  Otherwise returns NO
 */
RCT_EXPORT_METHOD(isScreenshotPolicyEnabled:(RCTResponseSenderBlock)callback)
{
    BOOL isEnabled = [CAMDOReporter isScreenshotPolicyEnabled];
    callback(@[@(isEnabled)]);
}

/**
 * Use this API to add a custom network event in the current session
 * 
 * @param url, string reprentation of the network URL
 * @param status, any NSInteger value
 * @param responseTime, any integer value
 * @param inBytes, any integer value
 * @param outBytes, any integer value
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * 
 * Successful execution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(logNetworkEvent:(NSString *) url withStatus:(NSInteger) status withResponseTime:(int64_t) responseTime withInBytes:(int64_t) inBytes withOutBytes:(int64_t) outBytes completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter logNetworkEvent: url withStatus: status withResponseTime: responseTime withInBytes: inBytes withOutBytes: outBytes completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * Use this API to add a custom text event in the current session
 *
 * @param name is a string event name
 * @param value is a string event value
 * @param attributes is a Dictionary which can be used to send any extra parameters
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 *
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 *
 */
RCT_EXPORT_METHOD(logTextMetric:(NSString *) name withValue:(NSString *) value withAttributes:(nullable NSDictionary *) attributes completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter logTextMetric: name withValue: value withAttributes: attributes completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * Use this API to add a custom numeric event of type double in the current session
 *
 * @param name is a string event name
 * @param value is a double event value
 * @param attributes is a Dictionary which can be used to send any extra parameters
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock.
 *
 * Successful execution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 *
 */
RCT_EXPORT_METHOD(logNumericMetric:(NSString *) name withValue:(double) value withAttributes:(nullable NSDictionary *) attributes completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter logNumericMetric: name withValue: value withAttributes: attributes completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/**
 * Use this API to force an upload event.
 * This is bulk/resource consuming operation and should be used with caution
 *
 * @param completionBlock with response as NSDictionary and error object
 *
 * Response is a key,value paired array which contains:
 *  the Key 'CAMDOResponseKey' which holds the URLResponse details
 *  the key 'CAMDOTotalUploadedEvents' which holds the total number of events uploaded
 * error object is nil if the API call is completed, otherwise an error
 */
//TODO: Need to use threading: because uploadEvents operation might take a long time to complete
RCT_EXPORT_METHOD(uploadEventsWithCompletionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter uploadEventsWithCompletionHandler: ^(NSDictionary *response, NSError *error) {
      completionBlock(@[RCTNullIfNil(response), RCTNullIfNil(error)]);
    }];
}
@end
