import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityLaunchScreen extends StatefulWidget {
  final String assetBundlePath;
  const UnityLaunchScreen({super.key, required this.assetBundlePath});

  @override
  State<UnityLaunchScreen> createState() => _UnityLaunchScreenState();
}

class _UnityLaunchScreenState extends State<UnityLaunchScreen> {
  late UnityWidgetController _unityWidgetController;

  @override
  void initState() {
    super.initState();
  }

  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;

    _unityWidgetController.postMessage(
      "MyBundleLoader", // Match the GameObject name in Unity
      "LoadBundle", // This should be the method in your Unity script
      widget.assetBundlePath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unity View"),
        iconTheme: IconThemeData(color: Colors.white, weight: 30),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 25,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: UnityWidget(
        onUnityCreated: onUnityCreated,
        fullscreen: true,
        useAndroidViewSurface: true,
      ),
    );
  }
}
