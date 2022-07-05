import 'package:admin/src/app/visuals/models/visuals.models.dart';
import 'package:admin/src/app/visuals/repository/visuals.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'visuals_event.dart';
part 'visuals_state.dart';

class VisualsBloc extends Bloc<VisualsEvent, VisualsState> {
  final VisualsRepository repository;
  VisualsBloc(this.repository) : super(VisualsInitial()) {
    on<VisualsEvent>(
      (event, emit) async {
        if (event is LoadVisuals) {
          try {
            emit(VisualsLoading());
            var videos = await repository.getVisualsPosts();
            emit(VisualsLoaded(videos));
          } catch (e) {
            print(e.toString());

            emit(VisualsLoadingError(e.toString()));
          }
        }
      },
    );
  }
}
