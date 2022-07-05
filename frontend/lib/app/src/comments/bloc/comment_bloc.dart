import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prymo_mobile_app/app/src/comments/repository/comment.repository.dart';
import 'package:prymo_mobile_app/app/src/home/models/home.models.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<CommentEvent>((event, emit) async {
      if (event is AddComment) {
        try {
          emit(CommentLoading());
          var content = await commentRepository.addComment(event.comment);
          if (content == event.comment.content) {
            emit(CommentLoaded(event.comment));
          } else {
            emit(CommentLoadingError("Something went wrong, Please try again"));
          }
        } catch (e) {
          print(e.toString());
          emit(CommentLoadingError(e.toString()));
        }
      }
    });
  }
}
