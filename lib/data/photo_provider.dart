import 'package:flutter/material.dart';
import 'package:image_search/UI/home_view_model.dart';

class PhotoProvider extends InheritedWidget {
  final HomeViewModel viewModel;

  PhotoProvider({Key? key, required this.viewModel, required Widget child})
    : super(key: key, child: child);

  static PhotoProvider of(BuildContext context) {
    final PhotoProvider? result = context
        .dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PhotoProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return true;
  }
}
