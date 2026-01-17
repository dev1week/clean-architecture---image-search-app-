

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search/data/data_source/result.dart';

import '../../domain/model/photo.dart';

class PixabayApi{
  final http.Client client;

  PixabayApi(this.client);

  final baseUrl = "https://pixabay.com/api/";
  //it's a public key provided by pixabay api docs.
  final key = '53890814-cfa8ab286b708e4201f7aeb5c';

  Future<Result<Iterable<dynamic>>> fetch(String query) async{
    try{
      final response =  await client.get(Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      Iterable hits = jsonResponse['hits'];

      return Result.success(hits); 
    }catch(e){
      return Result.error(('network error'));
    }

  }
}