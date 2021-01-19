import 'package:beatscratch_plugin/beatscratch_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VoidCallback listener;
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    listener = () { setState(() {});};
    BeatScratchPlugin.onSynthesizerStatusChange = listener;
    BeatScratchPlugin.pressedMidiControllerNotes.addListener(listener);
  }
  @override
  void dispose() {
    BeatScratchPlugin.onSynthesizerStatusChange = null;
    BeatScratchPlugin.pressedMidiControllerNotes.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BeatScratch Plugin Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('Synthesizer available: ${BeatScratchPlugin.isSynthesizerAvailable}\n'),
              Text('Keys Pressed: ${BeatScratchPlugin.pressedMidiControllerNotes.value}\n'),
            ],
          ),
        ),
      ),
    );
  }
}
