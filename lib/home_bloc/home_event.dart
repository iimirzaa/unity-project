part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LaunchUnityButtonClick extends HomeEvent { //Launch Unity Button clicked Event aka loading state event
  final bool isloading;
  LaunchUnityButtonClick({required this.isloading});
}

class LaunchUnity extends HomeEvent {// Launch Unity event
  final bool isloading;
  LaunchUnity({required this.isloading});
}

class DownloadNowButtonClicked extends HomeEvent {}// Download now button clicked event

class StartBundleDownload extends HomeEvent {} //download start event

class _BundleDownloadProgress extends HomeEvent {// internal event to show progress
  final double progress;
  _BundleDownloadProgress(this.progress);
}
