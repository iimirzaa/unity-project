import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';//importing bloc
import 'package:flutter_unity_communication/features/download_feature/presentation/download_now.dart';
import 'package:flutter_unity_communication/features/unity_screen/unity_presentation/unitypresentation.dart';
import 'package:flutter_unity_communication/home_bloc/home_bloc.dart';//importing home bloc i created

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isloading = false; //set to false initially

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(// using BlocConsumer to handle to events in this page
      listener: (context, state) async {
        if (state is LoadingState) {
          setState(() { //setting loading to true on Loading State
            isloading = state.isloading;
          });
        }
        if (state is LaunchUnityState) {// navigating to Unity Screen after 3 seconds as per requirement
          await Future.delayed(Duration(seconds: 3));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => UnityView()),
          );
          await Future.delayed(Duration(milliseconds: 50));//used a small delay in setting loading state back to normal
          setState(() {
            isloading = state.isloading;
          });
        }

        if (state is DownloadNowState) { // Navigating to Download Screen when Download now button clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DownloadUnityBundlePage()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Flutter + Unity"),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 25,
              color: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isloading //checking whether to show Circular progress Indicator or Cards
                    ? CircularProgressIndicator(backgroundColor: Colors.amber)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          Container(
                            height: 400,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 100,
                                  color: Colors.deepPurple,
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "Flutter + Unity Communication",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 6,
                                    shadowColor: Colors.deepPurpleAccent,
                                    backgroundColor: Colors.deepPurple,
                                    minimumSize: Size(350, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                      LaunchUnityButtonClick(
                                        isloading: isloading,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Launch Unity",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 400,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8F9FA), // Light sleek color
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  size: 100,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 30),

                                Text(
                                  "Download Unity from Drive",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                SizedBox(height: 30),
                                ElevatedButton( //Download Now button
                                  style: ElevatedButton.styleFrom(
                                    elevation: 6,
                                    shadowColor: Colors.deepPurpleAccent,
                                    backgroundColor: Color(0xFF72C229),
                                    minimumSize: Size(350, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                      DownloadNowButtonClicked(),
                                    );
                                  },
                                  child: Text(
                                    "Download Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
