part of 'video_bloc.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<VideoModel> videos;

  VideoLoaded(this.videos);
}

class VideoLoadingError extends VideoState {
  final String message;

  VideoLoadingError(this.message);
}
