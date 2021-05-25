import 'package:bloc/bloc.dart';
import 'package:flutter_application/model/Photo.dart';
import 'package:flutter_application/services/PhotoService.dart';
import 'package:meta/meta.dart';

part 'cubitphoto_state.dart';

class CubitphotoCubit extends Cubit<CubitphotoState> {
  final PhotoService service;
  CubitphotoCubit(this.service) : super(CubitphotoInitial());
  Future<void> load() async {
    try {
      emit(CubitphotoLoading());
      List photo = await service.getPhotos();
      emit(CubitphotoLoaded(photo));
    }
    catch(e){
      emit(CubitphotoError(e.toString()));
    }
  }
}