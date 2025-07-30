part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadingState extends HomeState {
  final bool isloading;
  LoadingState({required this.isloading});
}

class LaunchUnityState extends HomeState {
  final bool isloading;
  LaunchUnityState({required this.isloading});
}

class DownloadNowState extends HomeState {}

class BundleDownloading extends HomeState {
  final double progress;
  BundleDownloading(this.progress);
}

class BundleDownloaded extends HomeState {
  final String filePath;
  BundleDownloaded(this.filePath);
}

class BundleDownloadFailed extends HomeState {
  final String error;
  BundleDownloadFailed(this.error);
}
