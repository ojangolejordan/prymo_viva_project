part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class AddComment extends CommentEvent {
  final Comment comment;

  AddComment(this.comment);
}
