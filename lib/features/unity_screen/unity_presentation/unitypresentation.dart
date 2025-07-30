import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityView extends StatefulWidget {
  const UnityView({super.key});

  @override
  State<UnityView> createState() => _UnityViewState();
}

class _UnityViewState extends State<UnityView> {
  late UnityWidgetController _unityWidgetController;

  // Called when Unity is created
  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
  }

  // Called when Unity sends a message
  void onunityMessage(message) {
    final content = message.toString();

    print("Unity Message received: ${content}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message from Unity: $content'),
        duration: Duration(seconds: 10),
        backgroundColor: Colors.deepPurple,
      ),
    );

    if (content == "Unity Quit") {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unity App"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 6,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: UnityWidget(
        onUnityCreated: onUnityCreated,
        onUnityMessage: onunityMessage,
        fullscreen: false,
      ),
    );
  }
}
