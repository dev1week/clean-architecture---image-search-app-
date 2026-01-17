import 'package:flutter/material.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';
import 'package:image_search/presentation/home/home_screen.dart';
import 'package:image_search/data/repository/photo_api_repository_impl.dart';
import 'package:image_search/presentation/home/home_view_model.dart';
import 'data/data_source/pixabay_api.dart';
import 'data/photo_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: PhotoProvider(
        viewModel: HomeViewModel(PhotoApiRepositoryImpl()),
        child: const HomeScreen(),
      ),
    );
  }
}
