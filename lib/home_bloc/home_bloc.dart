import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LaunchUnityButtonClick>((event, emit) async {
      emit(LoadingState(isloading: true)); //on Click of Launch Unity first loading state will be emitted
      emit(LaunchUnityState(isloading: false));// then Launching state
    });
    on<DownloadNowButtonClicked>((event, emit) {
      emit(DownloadNowState()); //emitting state to navigate on Downloading Page
    });
    on<StartBundleDownload>((event, emit) async {
      try {
        final driveFileId = '1BSGu-krbJ6qBKeGef6HHzZnasR2NQ0_a';// file key of assets stored on Google Drive
        final url =
            "https://drive.google.com/uc?export=download&id=$driveFileId"; //converted it into downloadable link/url

        final dir = await getApplicationDocumentsDirectory();//getting path where this file will be stored
        final savePath = '${dir.path}/mybundle.mybundle';//setting save path

        await Permission.storage.request();// getting storage request if needed

        Dio dio = Dio(); //Dio is built on top of HTTP which provide POST,GET,UPLOAD AND DOWNLOAD LIKE FUNCTIONALITY
        await dio.download(
          url,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              add(_BundleDownloadProgress(received / total)); // internal event
            }
          },
        );

        emit(BundleDownloaded(savePath));
      } catch (e) {
        emit(BundleDownloadFailed(e.toString()));//emitting error state
      }
    });

    // Private progress update
    on<_BundleDownloadProgress>((event, emit) { //sending progress to frontend
      emit(BundleDownloading(event.progress));
    });
  }
}
