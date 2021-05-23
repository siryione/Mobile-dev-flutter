part of 'moviecubit_cubit.dart';

@immutable
abstract class MoviecubitState {}

class MoviecubitInitial extends MoviecubitState {}

class MoviecubitLoading extends MoviecubitState {}

class MoviecubitLoaded extends MoviecubitState {
  final List<Movie> movies;
  MoviecubitLoaded(this.movies);
}

class MoviecubitError extends MoviecubitState {
  final String message;
  MoviecubitError(this.message);
}
