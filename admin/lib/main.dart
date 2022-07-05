import 'package:admin/src/app/home/bloc/video_bloc.dart';
import 'package:admin/src/app/home/repository/video.repository.dart';
import 'package:admin/src/app/users/bloc/user_bloc.dart';
import 'package:admin/src/app/users/repository/users.repository.dart';
import 'package:admin/src/app/visuals/bloc/visuals_bloc.dart';
import 'package:admin/src/app/visuals/repository/visuals.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'meta/pages/navpage.dart';

void main() {
  runApp(MyApp(
    usersRepository: UsersImpl(),
    visualsRepository: VisualsImpl(),
    videoRepository: VideoImpl(),
  ));
}

class MyApp extends StatelessWidget {
  final UsersRepository usersRepository;
  final VisualsRepository visualsRepository;
  final VideoRepository videoRepository;

  const MyApp(
      {required this.usersRepository,
      required this.videoRepository,
      required this.visualsRepository});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VideoBloc(videoRepository)),
        BlocProvider(create: (context) => VisualsBloc(visualsRepository)),
        BlocProvider(create: (context) => UserBloc(usersRepository)),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            fontFamily: "Circular",
            appBarTheme: AppBarTheme(color: Color(0xff121212), elevation: 0),
            scaffoldBackgroundColor: Color(0xff121212),
            brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        title: "Prymo Admin",
        home: NavPage(),
      ),
    );
  }
}
