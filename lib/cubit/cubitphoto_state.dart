part of 'cubitphoto_cubit.dart';

@immutable
abstract class CubitphotoState {}

class CubitphotoInitial extends CubitphotoState {}

class CubitphotoLoading extends CubitphotoState {}

class CubitphotoLoaded extends CubitphotoState {
  final List<Photo> photos;
  CubitphotoLoaded(this.photos);
}

class CubitphotoError extends CubitphotoState {
  final String message;
  CubitphotoError(this.message);
}
