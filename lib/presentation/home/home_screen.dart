import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search/data/photo_provider.dart';
import 'package:image_search/presentation/home/home_ui_event.dart';
import 'package:image_search/presentation/home/home_view_model.dart';
import '../../domain/model/photo.dart';
import 'component/photo_widget.dart';
import 'home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void dispose() {
    _controller.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = PhotoProvider.of(context).viewModel;

      _subscription = viewModel.eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar(:final data):
            showSnackBar(data);
            break;
        }
      });
    });
  }

  void showSnackBar(String data) {
    final snackBar = SnackBar(content: Text(data));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = PhotoProvider.of(context).viewModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("이미지 검색 앱", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    viewModel.fetch(_controller.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          StreamBuilder<HomeState>(
            stream: viewModel.stateStream,
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final state = snapshot.data!;

              if (state.isLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text("이미지를 불러오는 중..."),
                    ],
                  ),
                );
              }

              if (state.photos.isEmpty) {
                return const Expanded(
                  child: Center(child: Text("검색 결과가 없습니다.")),
                );
              }

              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: state.photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return PhotoWidget(photo: state.photos[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
