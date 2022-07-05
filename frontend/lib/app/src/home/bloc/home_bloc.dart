import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prymo_mobile_app/app/src/home/models/home.models.dart';
import 'package:prymo_mobile_app/app/src/home/repository/home.repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetHomeVideos) {
        try {
          emit(HomeLoading());
          var videos = await repository.getHomePosts();
          emit(HomeLoaded(videos));
        } catch (e) {
          print(e.toString());

          emit(HomeLoadingError(e.toString()));
        }
      }
    });
  }
}
