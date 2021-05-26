import 'package:bloc/bloc.dart';
import 'package:flutter_application/classes/Movie.dart';
import 'package:meta/meta.dart';

part 'aboutmoviecubit_state.dart';

class AboutmoviecubitCubit extends Cubit<AboutmoviecubitState> {
  final MovieService serviceAbout;
  AboutmoviecubitCubit(this.serviceAbout) : super(AboutmoviecubitInitial());
  Future<void> load(String id) async {
    try {
      emit(AboutmoviecubitLoading());
      Movie movie = await serviceAbout.getMovie(id);
      print('loading');
      emit(AboutmoviecubitLoaded(movie));
    } catch (e) {
      emit(AboutmoviecubitError(e.toString()));
    }
  }
}
