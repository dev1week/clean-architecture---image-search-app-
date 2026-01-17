import 'dart:async';
import '../../data/data_source/result.dart';
import '../../domain/repository/photo_api_repository.dart';
import 'home_state.dart';
import 'home_ui_event.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  HomeViewModel(this.repository);

  final _eventController = StreamController<HomeUiEvent>();
  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  final _stateController = StreamController<HomeState>()..add(HomeState());
  Stream<HomeState> get stateStream => _stateController.stream;
  HomeState _state = HomeState();

  Future<void> fetch(String query) async {
    _updateState(_state.copyWith(isLoading: true));

    final result = await repository.fetch(query);

    switch (result) {
      case Success(data: final data):
        _updateState(_state.copyWith(photos: data, isLoading: false));
      case Error(message: final msg):
        _updateState(_state.copyWith(isLoading: false));
        _eventController.add(HomeUiEvent.showSnackBar(msg));
    }
  }

  void _updateState(HomeState newState) {
    _state = newState;
    _stateController.add(_state);
  }
}
