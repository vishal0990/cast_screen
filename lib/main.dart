import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(CastApp());

class CastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cast App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cast Screen Example"),
        actions: [
          CastButton(), // Add a casting button
        ],
      ),
      body: const Center(
        child: Text("Hello, this is your app's main screen."),
      ),
    );
  }
}

class CastButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.cast),
      onPressed: () {
        // Open cast menu
        _openCastMenu(context);
      },
    );
  }

  void _openCastMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text("Connect to TV"),
              onTap: () {
                // Handle connection logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.laptop),
              title: const Text("Connect to Laptop"),
              onTap: () {
                // Handle connection logic
              },
            ),
          ],
        );
      },
    );
  }
}

class CastController {
  static const _channel = MethodChannel('com.example.castapp/cast');

  static Future<void> startCasting() async {
    await _channel.invokeMethod('startCasting');
  }

  static Future<void> stopCasting() async {
    await _channel.invokeMethod('stopCasting');
  }
}

class CastLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      CastController.stopCasting();
    }
  }
}
