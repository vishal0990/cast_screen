import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: CastScreen()));
}

class CastScreen extends StatefulWidget {
  @override
  _CastScreenState createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CastService.startCasting(); // Start casting when the screen is loaded
  }

  @override
  void dispose() {
    CastService.stopCasting(); // Stop casting when the app is destroyed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      CastService
          .pauseCasting(); // Pause casting when the app goes to the background
    } else if (state == AppLifecycleState.resumed) {
      CastService.startCasting(); // Resume casting when the app is back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cast Screen')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: CastService.pauseCasting,
              child: Text('Pause Casting'),
            ),
            ElevatedButton(
              onPressed: CastService.stopCasting,
              child: Text('Stop Casting'),
            ),
          ],
        ),
      ),
    );
  }
}

class CastService {
  static const MethodChannel _channel = MethodChannel('screen_cast_channel');

  static Future<void> startCasting() async {
    try {
      await _channel.invokeMethod('startCasting');
    } catch (e) {
      print("Failed to start casting: $e");
    }
  }

  static Future<void> pauseCasting() async {
    try {
      await _channel.invokeMethod('pauseCasting');
    } catch (e) {
      print("Failed to pause casting: $e");
    }
  }

  static Future<void> stopCasting() async {
    try {
      await _channel.invokeMethod('stopCasting');
    } catch (e) {
      print("Failed to stop casting: $e");
    }
  }
}
