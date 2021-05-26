import 'package:bloc/bloc.dart';
import 'package:flutter_application/classes/Movie.dart';
import 'package:meta/meta.dart';

part 'movieslistcubit_state.dart';

class MovieslistcubitCubit extends Cubit<MovieslistcubitState> {
  final MovieService service;
  MovieslistcubitCubit(this.service) : super(MovieslistcubitInitial());
  Future<void> load(String q) async {
    try {
      emit(MovieslistcubitLoading());
      print('before');
      List<Movie> movieslist = await service.getMovies(q);

      emit(MovieslistcubitLoaded(movieslist));
    } catch (e) {
      emit(MovieslistcubitError(e.toString()));
    }
  }
}
