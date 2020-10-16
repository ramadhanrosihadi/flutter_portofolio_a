import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'DataResponse.dart';

enum Method { POST, GET }

class ApiProvider {
  static Future<DataResponse> callApi(DataRequest dataRequest) async {
    DataResponse dataResponse = DataResponse(dataRequest: dataRequest);
    try {
      Dio dio = Dio();
      await addInterceptor(dio);
      Response response;
      if (dataRequest.formData != null) {
        response = await dio.post(dataRequest.url, data: dataRequest.formData);
      } else {
        response = await dio.post(dataRequest.url, data: dataRequest.payload);
      }

      dataResponse = DataResponse.fromResponse(response);
      dataResponse.dataRequest = dataRequest;
      if (dataResponse.responseCode == 401) {
        //Todo logout
      }
      return dataResponse;
    } catch (e) {
      dataResponse.responseCode = 400;
      dataResponse.errors = e.toString();
      return dataResponse;
    }
  }

  static Future addInterceptor(Dio dio) async {
    if (Var.isDebugMode) {
      dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90));
    }
    dio.options.headers['accept'] = 'application/json';
    dio.options.headers['token-Firebase'] = "-";
    dio.options.headers['device-Info'] = await Fun.deviceInfo();
    dio.options.headers['version-Code'] = await Fun.currentVersionCode();
    dio.options.headers['version-Name'] = await Fun.currentVersionName();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.followRedirects = false;
    var user = await UserPref.loadUser();
    if (user.access != null) {
      String authorization = "${user.access.token_type} ${user.access.access_token}";
      dio.options.headers['authorization'] = authorization;
    }
  }
}
