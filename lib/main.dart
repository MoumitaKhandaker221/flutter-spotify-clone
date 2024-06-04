import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/view/get_started/get_started_page.dart';
import 'bloc/album_bloc/album_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';
import 'bloc/player_bloc/player_bloc.dart';
import 'db_helper/db_helper.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyB0NeJfB8DWCe8IngEAtt4ySN2sSgf_uE0',
    appId: '1:596551361707:android:9f4d204b38fa10090683ee',
    messagingSenderId: 'sendid',
    projectId: 'credentials-a07ac',
    storageBucket: 'credentials-a07ac.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => HomeBloc(dbHelper: DbHelper()),
        ),
        BlocProvider(
          create: (_) => PlayerBloc(player: AudioPlayer()),
        ),
        BlocProvider(
          create: (_) => AlbumBloc(pageController: PageController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: GetStartedPage(),
      ),
    );
  }

 /* Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: const GetStartedPage(),
    );
  }*/



}
