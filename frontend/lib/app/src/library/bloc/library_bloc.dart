import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prymo_mobile_app/app/src/library/models/library.models.dart';
import 'package:prymo_mobile_app/app/src/library/repository/library.repository.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryRepository repository;
  LibraryBloc(this.repository) : super(LibraryInitial()) {
    on<LibraryEvent>(
      (event, emit) async {
         if (event is LoadLibrary) {
        try {
          emit(LibraryLoading());
          var videos = await repository.getLibraryPosts();
          emit(LibraryLoaded(videos));
        } catch (e) {
          print(e.toString());

          emit(LibraryLoadingError(e.toString()));
        }
      }
      },
    );
  }
}
