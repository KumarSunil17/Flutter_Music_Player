#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

    FlutterMethodChannel* equalizerChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"eq_settings"
                                            binaryMessenger:controller];

    [equalizerChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    if ([@"equalizer" isEqualToString:call.method]) {
      result([FlutterError errorWithCode:@"UNAVAILABLE"
                                       message:@"Equalizer setting unavailable"
                                       details:nil]);
     } else {
           result(FlutterMethodNotImplemented);
         }
     }];

    [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
