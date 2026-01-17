import 'dart:async';
import '../../domain/repository/photo_api_repository.dart';
import '../../domain/model/photo.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async{
    final result = await repository.fetch(query);
    _photoStreamController.add(result);
  }
}