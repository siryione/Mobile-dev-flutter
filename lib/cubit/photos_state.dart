part of 'photos_cubit.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<String> photoes;
  PhotosLoaded(this.photoes);
}

class PhotosError extends PhotosState {
  final String message;
  PhotosError(this.message);
}
