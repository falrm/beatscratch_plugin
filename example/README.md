# beatscratch_plugin_example

Demonstrates how to use the BeatScratch Plugin.

## Getting Started

This project is a starting point for a BeatScratch application.

It's as simple as most Flutter plugins (add it to your pubspec and install),
but with an additional configuration step for AudioKit on iOS/macOS. We can't do 
this with CocoaPods because of reasons with XCode 12 and
CocoaPods not playing nice and stuff. IDK, I'm not really an experienced
dev on Apple platforms. I open sourced it and ported a bunch of my private code
to the plugin format so you could fix that if you like!

### Setting up AudioKit (after normal Flutter setup)
You must manually add an AudioKit 4.11.1 or 4.11.2 `xcframework` to build for iOS and macOS.

1. Download 4.11.1 or 4.11.2 (or later) in `xcframework` format from
    [AudioKit releases](https://github.com/AudioKit/AudioKit/releases). Save these somewhere
    permanent (I, for now, keep them in e.g. `~/Development/AudioKit Frameworks/4.11.2/AudioKit.xcframework`)
    * Don't change the name from `AudioKit.xcframework`. Keep the UI one if you want to use it, but it's not relevant to BeatScratch or Flutter UIs.
    * Keep this Finder window open.
2. Open your XCode Workspace (from your Flutter root, `open ios/Runner.xcworkspace`).
    * You'll also have to do this for macOS if you're targeting it.
3. Expand the "Runner" Project project in the XCode Workspace, find, and (after reading ahead)
   delete the red `AudioKit.xcframework` file.
4. Drag the `AudioKit.xcframework` from step 1 into its place.

After these steps your example app should run normally. Remember to do it separately for
macOS if you target it!
   
### Basic Flutter help

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
