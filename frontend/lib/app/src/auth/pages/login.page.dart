import 'package:flutter/material.dart';
import 'package:prymo_mobile_app/app/meta/pages/navpage.dart';
import 'package:prymo_mobile_app/app/src/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prymo_mobile_app/app/src/auth/models/auth.models.dart';
import 'package:prymo_mobile_app/app/src/auth/pages/signup.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left :8.0),
          child: Text("Welcome Back!"),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state);
          if (state is AuthLoadingError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthLoaded) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return NavPage();
                },
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal : 25),
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(hintText: "Username"),
                  controller: usernameController),
              TextField(
                  decoration: InputDecoration(hintText: "Password"),
                  controller: passwordController,
                  
                  obscureText: true,
                  ),
                  SizedBox(height : 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              UserDataModel model = UserDataModel(
                                  username: usernameController.text,
                                  password: passwordController.text);

                              authBloc.add(TriggerLogin(model));
                            },
                      child: Center(
                        child: state is AuthLoading
                            ? Text("Loading")
                            : Text("Login"),
                      ));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do not have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignUpPage())),
                        child: Text("Register",
                            style: TextStyle(color: Colors.yellow)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
