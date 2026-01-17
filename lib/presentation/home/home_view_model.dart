import 'dart:async';
import '../../data/data_source/result.dart';
import '../../domain/repository/photo_api_repository.dart';
import '../../domain/model/photo.dart';
import 'home_ui_event.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  final _eventController = StreamController<HomeUiEvent>();
  Stream<HomeUiEvent> get eventStream => _eventController.stream;


  HomeViewModel(this.repository);

  Future<void> fetch(String query) async{
    final Result<List<Photo>> result = await repository.fetch(query);


    switch (result) {
      case Success<List<Photo>>():
        _photoStreamController.add(result.data);
      case Error<List<Photo>>():
        _eventController.add(HomeUiEvent.showSnackBar(result.message));
    }

  }
}