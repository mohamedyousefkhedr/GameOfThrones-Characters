import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../constants/strings.dart';
 
class CharactersApi {
  late Dio dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 15 * 1000,
      receiveTimeout: 15 * 1000,
    );

    dio = Dio(options);
  }
  Future<List<dynamic>> getCharacters() async {
    try {
      Response response = await dio.get('Characters');
      if (kDebugMode) {
        print(response.data.toString());
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
