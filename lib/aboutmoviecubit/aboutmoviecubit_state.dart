part of 'aboutmoviecubit_cubit.dart';

@immutable
abstract class AboutmoviecubitState {}

class AboutmoviecubitInitial extends AboutmoviecubitState {}

class AboutmoviecubitLoading extends AboutmoviecubitState {}

class AboutmoviecubitLoaded extends AboutmoviecubitState {
  final Movie movie;
  AboutmoviecubitLoaded(this.movie);
}

class AboutmoviecubitError extends AboutmoviecubitState {
  final String message;
  AboutmoviecubitError(this.message);
}
