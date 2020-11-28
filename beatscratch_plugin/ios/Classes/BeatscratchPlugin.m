#import "BeatScratchPlugin.h"
#if __has_include(<beatscratch_plugin/beatscratch_plugin-Swift.h>)
#import <beatscratch_plugin/beatscratch_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "beatscratch_plugin-Swift.h"
#endif

@implementation BeatscratchPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBeatScratchPlugin registerWithRegistrar:registrar];
}
@end
