import 'package:dio/dio.dart';
import 'package:flutter_starter_b/api/ApiProvider.dart';

class DataRequest {
  final Map<String, dynamic> payload;
  final FormData formData;
  final String url;
  final Method method;

  DataRequest({this.payload, this.url, this.method, this.formData});
}
