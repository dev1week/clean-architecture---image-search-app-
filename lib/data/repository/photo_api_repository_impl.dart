import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_search/data/data_source/pixabay_api.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';
import '../../domain/model/photo.dart';
import '../data_source/result.dart';


class PhotoApiRepositoryImpl extends PhotoApiRepository{

  final api = PixabayApi(http.Client()); 


  @override
  Future<Result<List<Photo>>> fetch(String query) async{
    final Result result =  await api.fetch(query );

    if(result is Error){
      return Result.error(result.message);
    }else if(result is Success){
      return Result.success(result.data.map((e) => Photo.fromJson(e)).toList());
    }else{
      return Result.error("not defined error");
    }
  }
}

