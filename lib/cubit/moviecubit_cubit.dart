import 'package:bloc/bloc.dart';
import 'package:flutter_application/model/Movie.dart';
import 'package:flutter_application/services/MovieService.dart';
import 'package:meta/meta.dart';

part 'moviecubit_state.dart';

class MoviecubitCubit extends Cubit<MoviecubitState> {
  final MovieService service;
  MoviecubitCubit(this.service) : super(MoviecubitInitial());
  Future<void> load(String query) async {
    try {
      emit(MoviecubitLoading());
      List movie = await service.getMovies(query);
      emit(MoviecubitLoaded(movie));
    }
    catch(e){
      emit(MoviecubitError(e.toString()));
    }
  }
}
