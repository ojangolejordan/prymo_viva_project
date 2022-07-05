part of 'library_bloc.dart';

@immutable
abstract class LibraryState {}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final List<VisualModel> models;

  LibraryLoaded(this.models);
}

class LibraryLoadingError extends LibraryState {
  final String message;

  LibraryLoadingError(this.message);
}
