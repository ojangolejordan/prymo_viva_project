part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<VideoModel> videos;

  HomeLoaded(this.videos);
}

class HomeLoadingError extends HomeState {
  final String message;

  HomeLoadingError(this.message);
}
