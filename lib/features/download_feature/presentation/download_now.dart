import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_unity_communication/features/unity_screen_downloadable/unity_presentation_ii/unity_export_presentation.dart';

import 'package:flutter_unity_communication/home_bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadUnityBundlePage extends StatelessWidget {
  const DownloadUnityBundlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeBloc>(context)..add(StartBundleDownload()),// starting download as soon as we navigate to this screen
      child: Scaffold(
        appBar: AppBar(
          title: Text("Downloading Bundle"),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          iconTheme: IconThemeData(color: Colors.white, weight: 30),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is BundleDownloaded) { // if download successful then navigate to launching screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UnityLaunchScreen(assetBundlePath: state.filePath),
                ),
              );
            } else if (state is BundleDownloadFailed) {// show error snack bar on failed download
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Download failed: ${state.error}"),
                  backgroundColor: Colors.redAccent,
                  duration: Duration(seconds: 3),
                  elevation: 6,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is BundleDownloading) { //show progress indicator on loading state
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: state.progress,
                      color: Colors.green,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Downloading: ${(state.progress * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                "Starting download...",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
