import 'package:bloc/bloc.dart';
import 'package:flutter_application/classes/Photo.dart';
import 'package:meta/meta.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  final PhotoService service;
  PhotosCubit(this.service) : super(PhotosInitial());
  Future<void> load() async {
    try {
      emit(PhotosLoading());
      List<String> photoes = await service.getPhotoes();
      emit(PhotosLoaded(photoes));
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }
}
