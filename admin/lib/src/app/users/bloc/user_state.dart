part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}


class UsersInitial extends UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<UserModel> models;

  UsersLoaded(this.models);
}

class UsersLoadingError extends UserState {
  final String message;

  UsersLoadingError(this.message);
}
