part of 'movieinfo_cubit.dart';

@immutable
abstract class MovieinfoState {}

class MovieinfoInitial extends MovieinfoState {}
class MovieinfoLoading extends MovieinfoState {}
class MovieinfoLoaded extends MovieinfoState {
  final Movie movie;
  MovieinfoLoaded(this.movie);
}
class MovieinfoError extends MovieinfoState {
  final String message;
  MovieinfoError(this.message);
}
