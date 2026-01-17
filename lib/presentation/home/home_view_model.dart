import 'dart:async';
import '../../data/data_source/result.dart';
import '../../domain/repository/photo_api_repository.dart';
import '../../domain/model/photo.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async{
    final Result<List<Photo>> result = await repository.fetch(query);


    if(result is Success<List<Photo>>){
      _photoStreamController.add(result.data);
    }else if(result is Error){

    }else{

    }


  }
}