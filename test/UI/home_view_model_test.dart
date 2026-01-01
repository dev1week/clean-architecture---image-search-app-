import 'package:flutter_test/flutter_test.dart';
import 'package:image_search/UI/home_view_model.dart';
import 'package:image_search/data/photo_api_repository.dart';
import 'package:image_search/data/pixabay_api.dart';
import 'package:image_search/model/Photo.dart';

void main() {
  test('when api fetch is invoked then photo stream updated ', () async {
    final viewModel = HomeViewModel(PixabayApi());

    await viewModel.fetch(('apple'));

    expect(viewModel.photoStream, emitsInOrder([isA<List<Photo>>()]));
  });
}

