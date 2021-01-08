import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'custom_exception.dart';
import 'package:foody/models/category.dart';

class Api {
  Api._();
  static String baseUrl = "https://my-json-server.typicode.com/hyb90/food-api/";
  static final Api apiClient = Api._();
  static final http.Client _httpClient = http.Client();
  Future<dynamic> getAllCategories() async {
    var data;
    try {
      final response = await _httpClient.get(
        baseUrl + "Categories",
      );
      data = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return data;
  }
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body);
        final Categories categories = Categories.fromJson(json);
        return categories.categories;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      default:
        throw FetchDataException(response.body.toString()+'error code : '+response.statusCode.toString());
    }
  }


}
