import 'dart:async';

import '../../domain/model/photo.dart';
import 'home_ui_event.dart';

class HomeState {
  final List<Photo> photos;
  final bool isLoading;

  HomeState({this.photos = const [], this.isLoading = false});

  HomeState copyWith({List<Photo>? photos, bool? isLoading}) {
    return HomeState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
