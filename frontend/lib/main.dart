import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prymo_mobile_app/app/meta/constants.dart';
import 'package:prymo_mobile_app/app/meta/pages/navpage.dart';
import 'package:prymo_mobile_app/app/src/auth/bloc/auth_bloc.dart';
import 'package:prymo_mobile_app/app/src/auth/pages/login.page.dart';
import 'package:prymo_mobile_app/app/src/auth/repository/auth.repository.dart';
import 'package:prymo_mobile_app/app/src/comments/bloc/comment_bloc.dart';
import 'package:prymo_mobile_app/app/src/comments/repository/comment.repository.dart';
import 'package:prymo_mobile_app/app/src/home/bloc/home_bloc.dart';
import 'package:prymo_mobile_app/app/src/home/repository/home.repository.dart';
import 'package:prymo_mobile_app/app/src/library/bloc/library_bloc.dart';
import 'package:prymo_mobile_app/app/src/library/repository/library.repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.openBox("authBox");
  await Hive.openBox("usernamebox");
  runApp(
    Prymo(
        commentRepository: CommentImpl(),
        homeRepository: HomeImpl(),
        authRepository: AuthImpl(),
        libraryRepository: LibraryImpl()),
  );
}

class Prymo extends StatelessWidget {
  final AuthRepository authRepository;
  final CommentRepository commentRepository;
  final HomeRepository homeRepository;
  final LibraryRepository libraryRepository;

  const Prymo(
      {required this.authRepository,
      required this.libraryRepository,
      required this.commentRepository,
      required this.homeRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommentBloc(commentRepository),
        ),
        BlocProvider(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider(
          create: (context) => LibraryBloc(libraryRepository),
        ),
        BlocProvider(create: (context) => HomeBloc(homeRepository)),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            fontFamily: "Circular",
            appBarTheme: AppBarTheme(color: Color(0xff121212), elevation: 0),
            scaffoldBackgroundColor: Color(0xff121212),
            brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        title: "Prymo Mobile App",
        home: PrymoHome(),
      ),
    );
  }
}

class PrymoHome extends StatelessWidget {
  const PrymoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Decider();
  }
}

class Decider extends StatefulWidget {
  const Decider({Key? key}) : super(key: key);

  @override
  State<Decider> createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HiveRepository.getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavPage();
          } else {
            return LoginPage();
          }
        });
  }
}
