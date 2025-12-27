
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Photo.dart';

class PixabayApi{
  final baseUrl = "https://pixabay.com/api/";
  //it's a public key provided by pixabay api docs.
  final key = '53890814-cfa8ab286b708e4201f7aeb5c';

  Future<List<Photo>> fetch(String query) async{
    final response = await http.get(Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];

    return hits.map((e)=> Photo.fromJson(e)).toList();
  }
}

