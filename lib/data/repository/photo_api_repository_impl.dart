import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_search/data/data_source/pixabay_api.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';
import '../../domain/model/photo.dart';


class PhotoApiRepositoryImpl extends PhotoApiRepository{

  final api = PixabayApi(http.Client()); 

  @override
  Future<List<Photo>> fetch(String query) async{
    var result =  await api.fetch(query );
    return result.map((e) => Photo.fromJson(e)).toList();
  }
}

