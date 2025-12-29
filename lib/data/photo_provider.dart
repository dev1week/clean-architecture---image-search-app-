import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_search/data/api.dart';
import '../model/Photo.dart';

class PhotoProvider extends InheritedWidget {

  final PixabayApi api;

  List<Photo> _photos = [];
  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  PhotoProvider({Key? key, required Widget child, required this.api})
    : super(key: key, child: child);

  static PhotoProvider of(BuildContext context){
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PhotoProvider found in context');
    return result!;
  }

  Future<void> fetch(String query) async{
    final result = await api.fetch(query);
    _photoStreamController.add(result);
  }

  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
  }
}
