import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unity_communication/features/home_feature/home_presentation/homeview.dart';
import 'package:flutter_unity_communication/home_bloc/home_bloc.dart';

void main() {
  runApp(
    //Multi-Bloc-Provider used to provide Bloc to every single View created in project
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => HomeBloc())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter + Unity Communication",
      debugShowCheckedModeBanner: false,
      home: HomeView(),// initially presenting home page
    );
  }
}
