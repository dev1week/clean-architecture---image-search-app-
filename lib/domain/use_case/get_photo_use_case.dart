import 'package:image_search/domain/repository/photo_api_repository.dart';

import '../../data/data_source/result.dart';
import '../model/photo.dart';

class GetPhotoUseCase {
  final PhotoApiRepository repository;

  GetPhotoUseCase(this.repository);

  Future<Result<List<Photo>>> execute(String query) async {
    final result = await repository.fetch(query);

    switch (result) {
      case Success<List<Photo>>():
        return Result.success(result.data.sublist(0, 3));
      case Error<List<Photo>>():
        return Result.error(result.message);
    }
  }
}
