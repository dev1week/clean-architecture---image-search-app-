import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search/data/photo_provider.dart';
import 'package:image_search/presentation/home/home_ui_event.dart';
import 'package:image_search/presentation/home/home_view_model.dart';
import '../../domain/model/photo.dart';
import 'component/photo_widget.dart';

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
          StreamBuilder<List<Photo>>(
            stream: viewModel.photoStream,
            builder: (context, photoSnapshot) {

              if (!photoSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final photos = photoSnapshot.data!;

              return StreamBuilder<bool>(
                stream: viewModel.isLoadingStream, // ViewModel에 만드신 로딩 스트림
                initialData: false,
                builder: (context, loadingSnapshot) {
                  final isLoading = loadingSnapshot.data ?? false;

                  if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Expanded(
                    child: photos.isEmpty
                        ? const Center(child: Text("검색 결과가 없습니다."))
                        : GridView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: photos.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                            itemBuilder: (context, index) {
                              return PhotoWidget(photo: photos[index]);
                            },
                          ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
