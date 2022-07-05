import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prymo_mobile_app/app/meta/pages/navpage.dart';
import 'package:prymo_mobile_app/app/src/auth/bloc/auth_bloc.dart';
import 'package:prymo_mobile_app/app/src/auth/models/auth.models.dart';
import 'package:prymo_mobile_app/app/src/auth/pages/login.page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text("Welcome to Prymo"),
      )),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state);
          if (state is AuthLoadingError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              TextField(decoration: InputDecoration(hintText: "Username"), controller: usernameController),
              TextField(decoration: InputDecoration(hintText: "First Name"), controller: firstNameController),
              TextField(decoration: InputDecoration(hintText: "Last Name"), controller: lastNameController),
              TextField(decoration: InputDecoration(hintText: "Email"), controller: emailController),
              TextField(decoration: InputDecoration(hintText: "Password"), controller: passwordController),
              SizedBox(height: 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              UserRegisterModel model = UserRegisterModel(
                                  username: usernameController.text.trim(),
                                  firstName: firstNameController.text.trim(),
                                  lastName: lastNameController.text.trim(),
                                  email: emailController.text.toLowerCase().trim(),
                                  password: passwordController.text.trim());

                              authBloc.add(TriggerSignUp(model));
                            },
                      child: Center(
                        child: state is AuthLoading ? Text("Loading") : Text("Login"),
                      ));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage())),
                        child: Text("Login", style: TextStyle(color: Colors.yellow)))
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
