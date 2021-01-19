import Foundation
import AudioKit
#if canImport(FlutterMacOS)
import FlutterMacOS
#elseif canImport(Flutter)
import Flutter
#endif

public class SwiftBeatScratchPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "BeatScratchPlugin", binaryMessenger: registrar.messenger())
    let instance = SwiftBeatScratchPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    BeatScratchPlugin.sharedInstance.attach(channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {

      case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
        break
      default:
        break
    }
  }
}
