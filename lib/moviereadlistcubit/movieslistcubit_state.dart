part of 'movieslistcubit_cubit.dart';

@immutable
abstract class MovieslistcubitState {}

class MovieslistcubitInitial extends MovieslistcubitState {}

class MovieslistcubitLoading extends MovieslistcubitState {}

class MovieslistcubitLoaded extends MovieslistcubitState {
  final List<Movie> movies;
  MovieslistcubitLoaded(this.movies);
}

class MovieslistcubitError extends MovieslistcubitState {
  final String message;
  MovieslistcubitError(this.message);
}
