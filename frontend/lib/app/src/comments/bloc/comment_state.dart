part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState{
  final Comment comment;

  CommentLoaded(this.comment);
}

class CommentLoadingError extends CommentState {
  final String message;

  CommentLoadingError(this.message);
}
