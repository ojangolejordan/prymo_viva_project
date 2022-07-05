part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class TriggerLogin extends AuthEvent {
  final UserDataModel model;

  TriggerLogin(this.model);
}

class TriggerSignUp extends AuthEvent {
  final UserRegisterModel model;

  TriggerSignUp(this.model);
}
