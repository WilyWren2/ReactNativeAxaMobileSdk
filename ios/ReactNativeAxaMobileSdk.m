// ReactNativeAxaMobileSdk.m

/**
 * iOS Native module bridge, that routes the calls to {@link CAMDOReporter} APIs. The React
 * Native app (from its js files) will call this native module, via the JavaScript Module wrapper
 * ReactNativeAxaMobileSdk.js, to use the AXA Custom metrics APIs.
 * <p>
 * Created by ay892045 on 07/15/2021.
 */

#import "ReactNativeAxaMobileSdk.h"
#import <UIKit/UIKit.h>
#import "CAMDOReporter.h"
#import<CoreLocation/CoreLocation.h>
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

//@implementation RCTConvert (SDKOptionsExtensions)
//    RCT_ENUM_CONVERTER(SDKOptions,(@{   @"SDKDefault"                       : 0,
//                                        @"SDKLogLevelSilent"                : (1 << 0),
//                                        @"SDKLogLevelVerbose"               : (1 << 1),
//                                        @"SDKCheckProfileOnRestartOnly"     : (1 << 2),
//                                        @"SDKUseNetworkProtocolSwizzling"   : (1 << 3), // By default we use NSURLConnection and NSURLSession delegates
//                                                                                        // to observe Network traffic.  This option adds the protocol
//                                                                                        // support if our delegates miss anything
//                                        @"SDKNoNetworkSwizzling"            : (1 << 4),
//                                        @"SDKNoWorkLightSwizzling"          : (1 << 5),
//                                        @"SDKNoGeoLocationCapturing"        : (1 << 6),
//                                        @"SDKCollectDeviceName"             : (1 << 7), // It is App developer's responsibility to provide a disclaimer to
//                                                                                        // the consumer that they are collecting this data.
//                                                                                        // By default CA SDK will NOT collect the device name
//                                        @"SDKUIWebViewDelegate"             : (1 << 8), // requires SDK build with private APIs
//                                        @"SDKFixedViewTitles"               : (1 << 9),
//                                        @"SDKNoCrashReporting"              : (1 << 10)
//                                        }),
//                        SDKDefault, integerValue)
//@end
@implementation RCTConvert (SDKErrorExtension)
    RCT_ENUM_CONVERTER(SDKError, (@{    @"ErrorNone"                        : @(ErrorNone),
                                        @"ErrorNoTransactionName"           : @(ErrorNoTransactionName),
                                        @"ErrorTransactionInProgress"       : @(ErrorTransactionInProgress),
                                        @"ErrorFailedToTakeScreenshot"      : @(ErrorFailedToTakeScreenshot),
                                        @"ErrorInvalidValuesPassed"         : @(ErrorInvalidValuesPassed)}),
                        ErrorNone, integerValue)
@end

//Enums to be specified for the pinningMode during the SSL handshake
@implementation RCTConvert (CAMDOSSLPinningModeExtension)
    RCT_ENUM_CONVERTER(CAMDOSSLPinningMode, (@{ @"CAMDOSSLPinningModeNone"                      : @(CAMDOSSLPinningModeNone),
                                                @"CAMDOSSLPinningModePublicKey"                 : @(CAMDOSSLPinningModePublicKey),
                                                @"CAMDOSSLPinningModeCertificate"               : @(CAMDOSSLPinningModeCertificate),
                                                @"CAMDOSSLPinningModeFingerPrintSHA1Signature"  : @(CAMDOSSLPinningModeFingerPrintSHA1Signature),
                                                @"CAMDOSSLPinningModePublicKeyHash"             : @(CAMDOSSLPinningModePublicKeyHash)}),
                       CAMDOSSLPinningModeNone, integerValue)
@end

@implementation ReactNativeAxaMobileSdk

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{ @"ErrorNone"                                  : @(ErrorNone),
            @"ErrorNoTransactionName"                       : @(ErrorNoTransactionName),
            @"ErrorTransactionInProgress"                   : @(ErrorTransactionInProgress),
            @"ErrorFailedToTakeScreenshot"                  : @(ErrorFailedToTakeScreenshot),
            @"ErrorInvalidValuesPassed"                     : @(ErrorInvalidValuesPassed),
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
            @"CAMAA_UPLOAD_INITIATED"                       : @"CAMAA_UPLOAD_INITIATED"}; //Register for SDK data upload notification. The receiver is notified when SDK uploads the data to the Collector.
};
/**
We should also implement + requiresMainQueueSetup to let React Native know if our module needs to be initialized on the main thread.
Otherwise we will see a warning that in the future our module may be initialized on a background thread unless we explicitly opt out with + requiresMainQueueSetup:
*/
+ (BOOL)requiresMainQueueSetup
{
  return YES;  // only do this if our module initialization relies on calling UIKit!
}

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

/** APIS  **/
/* Initializes the SDK.  This call should be made as early as possible in the application life cycle
 * Typically, it is made at the beginning of didFinishLaunchingWithOptions in Application delegate class
 * @param options of the type SDKOptions
 * @param configDetails This should be of the type NSDictionary. This should be the content of the CAMAA plist
 * @param completionBlock which is a standard (BOOL completed, NSError *error)block
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(initializeSDKWithOptions:(SDKOptions) options configDetails:(NSDictionary *)configDetails completionHandler:(void(^)(BOOL completed, NSError *error)) completionBlock)
{
    [CAMDOReporter initializeSDKWithOptions:options configDetails:configDetails completionHandler:completionBlock];
}

/* Initializes the SDK.  This call should be made as early as possible in the application life cycle.
 * Typically, it is made at the beginning of didFinishLaunchingWithOptions in Application delegate class
 * @param options of the type SDKOptions.
 * @param completionBlock which is a standard (BOOL completed, NSError *error)block.
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(initializeSDKWithOptions:(SDKOptions) options completionHandler:(void(^)(BOOL completed, NSError *error)) completionBlock)
{
    [CAMDOReporter initializeSDKWithOptions:options completionHandler:completionBlock];
}

/* Use this API to enable SDK.  SDK is enabled by default
 * You need to call this API only if you called disableSDK earlier
 */
RCT_EXPORT_METHOD(enableSDK)
{
  [CAMDOReporter enableSDK];
}

/* Use this API to disable the SDK.  When disabled, SDK is completely out of the process
 */
RCT_EXPORT_METHOD(disableSDK)
{
  [CAMDOReporter disableSDK];
}

/* Returns if the SDK is currently enabled or not
 */
RCT_EXPORT_METHOD(isSDKEnabled:(RCTResponseSenderBlock)callback)
{
    BOOL isEnabled = [CAMDOReporter isSDKEnabled];
    callback(@[@(isEnabled)]);
}

/* Use this API to get the unique device ID generated by the SDK
 */
RCT_EXPORT_METHOD(deviceId:(RCTResponseSenderBlock)callback)
{
    NSString *deviceId = [CAMDOReporter deviceId];
    callback(@[deviceId]);
}

/* Get the customer ID.  If it not set, this API returns nil
 */
RCT_EXPORT_METHOD(customerId:(RCTResponseSenderBlock)callback)
{
    NSString *customerID = [CAMDOReporter customerId];
    callback(@[customerID]);
}

/* Use this API to set the customer ID.  If nil is passed, customer id us reset
 */
 
RCT_EXPORT_METHOD(setCustomerId:(NSString *) customerId callback:(RCTResponseSenderBlock)callback)
{
  SDKError error = [CAMDOReporter setCustomerId:customerId];
  callback(@[@(error)]);
}

/* Use this API to set custom session attribute.  Name and Value cannot be nil
 */
RCT_EXPORT_METHOD(setSessionAttribute:(NSString *) name withValue:(NSString *)value  callback:(RCTResponseSenderBlock)callback)
{
  SDKError error = [CAMDOReporter setSessionAttribute:name withValue:value];
  callback(@[@(error)]);
}

/* Stops collecting potentially sensitive data.
 * The following data is not collected when the app enters private zone
 *    - Screenshots
 *    - Location information including GPS and IP addresses
 *    - Value in the text entry fields
 */
RCT_EXPORT_METHOD(enterPrivateZone)
{
  [CAMDOReporter enterPrivateZone];
}

/* Starts collecting all data again
 */
RCT_EXPORT_METHOD(exitPrivateZone)
{
  [CAMDOReporter exitPrivateZone];
}

/* Returns if CA MAA SDK is in private zone or not
 */
RCT_EXPORT_METHOD(isInPrivateZone:(RCTResponseSenderBlock)callback)
{
    BOOL isInPrivateZone = [CAMDOReporter isInPrivateZone];
    callback(@[@(isInPrivateZone)]);
}

/* Returns the SDK computed APM header in key value format.  Returns nil if apm header cannot be computed
 */
RCT_EXPORT_METHOD(apmHeader:(RCTResponseSenderBlock)callback)
{
    NSDictionary *apmHeader = [CAMDOReporter apmHeader];
    callback(@[apmHeader]);
}


/* Adds data to SDK computed APM header with a semicolon (;) separation
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


/* Use this method to set the ssl pinning mode and array of pinned values. Supported pinning modes:
 *
 * This method expects array of values depending on the pinningMode
 *
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

/* Use this method to stop the current session.  No data will be logged until startSession API is called again
 */
RCT_EXPORT_METHOD(stopCurrentSession)
{
    [CAMDOReporter stopCurrentSession];
}

/* Use this methid to start a new session.  If a session is already in progress,
 * it will be ended and new session is started
 */
RCT_EXPORT_METHOD(startNewSession)
{
    [CAMDOReporter startNewSession];
}

/* Convenient method to stop the current session in progress and start a new session
 */
RCT_EXPORT_METHOD(stopCurrentAndStartNewSession)
{
    [CAMDOReporter stopCurrentAndStartNewSession];
}

/* This method can be used to start a transaction with name
 * Completion block can be used to verify whether transaction is started successfully or not
 * @param transactionName which is NSString
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(startApplicationTransactionWithName:(NSString *) transactionName completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter startApplicationTransactionWithName: transactionName completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/* This method can be used to start a transaction with serviceName
 * Completion block can be used to verify whether transaction is started successfully or not
 * @param transactionName which is NSString.
 * @param serviceName which is NSString.
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock.
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(startApplicationTransactionWithName:(NSString *) transactionName  service:(NSString *)serviceName completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter startApplicationTransactionWithName: transactionName service: serviceName completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/* This method can be used to stop a transaction with name
 * Completion block can be used to verify whether transaction is stopped successfully or not
 * @param transactionName which is NSString
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(stopApplicationTransactionWithName:(NSString *) transactionName completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter stopApplicationTransactionWithName: transactionName completionHandler:^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}
/* This method can be used to stop a transaction with serviceName
 * Completion block can be used to verify whether transaction is stopped successfully or not
 * @param transactionName which is NSString.
 * @param serviceName which is NSString.
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock.
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(stopApplicationTransactionWithName:(NSString *) transactionName failure:(NSString *) failure completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter stopApplicationTransactionWithName: transactionName failure:failure completionHandler:^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/* Call this method to provide feedback from the user after a crash
 * App has to register for CAMAA_CRASH_OCCURRED notification and collect the feedback from the use
 * while handling the notification
 */
RCT_EXPORT_METHOD(setCustomerFeedback:(NSString *) feedback)
{
    [CAMDOReporter setCustomerFeedback: feedback];
}

/* Set Location of the Customer/User by passing zip code and country.
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

/* This method can be used to send the screen shot of the current screen
 * @param name for the screen name, cannot be nil.
 * @param quality of the image. The value should be between 0.0 to 1.0. By default it is set to low quality.
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(sendScreenShot:(NSString *) name withQuality:(CGFloat) quality completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter sendScreenShot: name withQuality: quality completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}


RCT_EXPORT_METHOD(enableScreenShots:(BOOL) captureScreen)
{
    [CAMDOReporter enableScreenShots: captureScreen];
}

/* This method is to create custom app flow with dynamic views
 * @param name
 * @param loadTime
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(viewLoaded:(NSString *) name loadTime:(CGFloat) loadTime completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter viewLoaded: name loadTime: loadTime completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

RCT_EXPORT_METHOD(viewLoaded:(NSString *) name loadTime:(CGFloat) loadTime screenShot:(BOOL) screenCapture completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter viewLoaded: name loadTime: loadTime screenShot: screenCapture completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/* Name of the view to be ignored
 * Screenshots and transitions of the views that are in ignore list are not captured
 */
RCT_EXPORT_METHOD(ignoreView:(NSString *) viewName)
{
    [CAMDOReporter ignoreView: viewName];
}

/* List of names of the views to be ignored.  Screenshots and transitions of the views that are in ignore list
 * are not captured
 */
RCT_EXPORT_METHOD(ignoreViews:(NSSet *) viewNames)
{
    [CAMDOReporter ignoreViews: viewNames];
}

/* Returns YES if screenshots are enabled by policy.  Otherwise returns NO
 */
RCT_EXPORT_METHOD(isScreenshotPolicyEnabled:(RCTResponseSenderBlock)callback)
{
    BOOL isEnabled = [CAMDOReporter isScreenshotPolicyEnabled];
    callback(@[@(isEnabled)]);
}

/*
 * This method can be used to add custom network event in the current session
 * @param url, string reprentation of the network URL
 * @param status, any NSInteger value
 * @param responseTime, any integer value
 * @param inBytes, any integer value
 * @param outBytes, any integer value
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(logNetworkEvent:(NSString *) url withStatus:(NSInteger) status withResponseTime:(int64_t) responseTime withInBytes:(int64_t) inBytes withOutBytes:(int64_t) outBytes completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter logNetworkEvent: url withStatus: status withResponseTime: responseTime withInBytes: inBytes withOutBytes: outBytes completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}

/* This method can be used to add custom text event of type NSString in the current session
 * @param name, which is an event name
 * @param value, which is an event value
 * @param attributes which is of the type NSDictionary which can be used to send any extra parameters
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(logTextMetric:(NSString *) name withValue:(NSString *) value withAttributes:(nullable NSDictionary *) attributes completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter logTextMetric: name withValue: value withAttributes: attributes completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}
/*
 * This method can be used to add custom numeric event of type double in the current session
 * @param name, which is an event name
 * @param value, which is an event value
 * @param attributes which is of the type NSDictionary which can be used to send any extra parameters
 * @param completionBlock which is a standard (BOOL completed, NSError *error) completionBlock.
 * Successful exceution of the method will have completed as YES and error object is nil
 * In case of failure the completed is set to NO and error will have NSError object with domain,
 * code and localizedDescription.
 */
RCT_EXPORT_METHOD(logNumericMetric:(NSString *) name withValue:(double) value withAttributes:(nullable NSDictionary *) attributes completionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter logNumericMetric: name withValue: value withAttributes: attributes completionHandler: ^(BOOL completed, NSError *error) {
      completionBlock(@[@(completed), RCTNullIfNil(error)]);
    }];
}
/* Force upload event(s). This is bulk/resource consuming operation and should be used with caution
 * This method takes a completion block as the parameter
 * @param completionBlock with response as NSDictionary and error object
 * Response dictionary conatins the Key 'CAMDOResponseKey' which holds the URLResponse details
 * and the key 'CAMDOTotalUploadedEvents' which holds the total number of events uploaded
 */
RCT_EXPORT_METHOD(uploadEventsWithCompletionHandler:(RCTResponseSenderBlock) completionBlock)
{
    [CAMDOReporter uploadEventsWithCompletionHandler: ^(NSDictionary *response, NSError *error) {
      completionBlock(@[RCTNullIfNil(response), RCTNullIfNil(error)]);
    }];
}
@end
