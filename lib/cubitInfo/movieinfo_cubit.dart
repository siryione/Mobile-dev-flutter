import 'package:bloc/bloc.dart';
import 'package:flutter_application/model/Movie.dart';
import 'package:flutter_application/services/MovieService.dart';
import 'package:meta/meta.dart';

part 'movieinfo_state.dart';

class MovieinfoCubit extends Cubit<MovieinfoState> {
  final MovieService service;
  MovieinfoCubit(this.service) : super(MovieinfoInitial());
  Future <void> load(String id) async {
    try{
      emit(MovieinfoLoading());
      print('loading');
      Movie movie = await service.getMovie(id);
      emit(MovieinfoLoaded(movie));
    }
    catch (e) {
      emit(MovieinfoError(e.toString()));
    }
  }
}
