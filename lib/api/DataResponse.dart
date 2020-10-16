import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';

class DataResponse {
  int responseCode;
  String message;
  String errors;
  String data;
  DataRequest dataRequest;
  DataResponse({this.responseCode, this.message, this.errors, this.data, this.dataRequest});

  Map<String, dynamic> toMap() {
    return {
      'response_code': responseCode,
      'message': message,
      'errors': errors,
      'data': data,
    };
  }

  factory DataResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DataResponse(
      responseCode: map['response_code']?.toInt(),
      message: map['message'],
      errors: map['erros'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DataResponse.fromJson(String source) => DataResponse.fromMap(json.decode(source));

  @override
  String toString() => 'DataResponse(response_code: $responseCode, message: $message, errors: $errors, data: $data)';

  bool isSuccess() => responseCode == 200;
  bool isTokenExpired() => responseCode == 401;

  factory DataResponse.fromResponse(Response response) {
    DataResponse dataResponse = DataResponse();
    dataResponse.responseCode = response.statusCode;
    dataResponse.errors = "";
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(jsonEncode(response.data));
      dataResponse.responseCode = responseJson['response_code'];
      dataResponse.message = responseJson['message'];
      dataResponse.errors += "[${dataResponse.responseCode}] (${responseJson['errors'].length}) | ";
      for (var error in responseJson['errors']) {
        dataResponse.errors += error + "__";
      }
      dataResponse.data = jsonEncode(responseJson['data']);
    } else {
      dataResponse.message = null;
      dataResponse.errors = 'Terjadi kesalahan';
    }
    return dataResponse;
  }

  bool isCalled(String url) {
    if (dataRequest == null) return false;
    return dataRequest.url == url;
  }
}
