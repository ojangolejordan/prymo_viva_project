import 'package:admin/src/app/home/models/video.models.dart';
import 'package:admin/src/app/home/repository/video.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository repository;
  VideoBloc(this.repository) : super(VideoInitial()) {
    on<VideoEvent>((event, emit) async {
      if (event is GetVideos) {
        try {
          emit(VideoLoading());
          var videos = await repository.getVideos();
          emit(VideoLoaded(videos));
        } catch (e) {
          print(e.toString());

          emit(VideoLoadingError(e.toString()));
        }
      }
    });
  }
}
