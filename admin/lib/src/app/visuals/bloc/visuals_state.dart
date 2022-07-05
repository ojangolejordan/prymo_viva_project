part of 'visuals_bloc.dart';

@immutable
abstract class VisualsState {}

class VisualsInitial extends VisualsState {}

class VisualsLoading extends VisualsState {}

class VisualsLoaded extends VisualsState {
  final List<VisualModel> models;

  VisualsLoaded(this.models);
}

class VisualsLoadingError extends VisualsState {
  final String message;

  VisualsLoadingError(this.message);
}
