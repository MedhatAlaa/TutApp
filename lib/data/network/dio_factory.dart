// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/constants.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    String language = await _appPreferences.getAppLanguage();
    Dio dio = Dio();
    Map<String, dynamic> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: AppConstants.token,
      DEFAULT_LANGUAGE: language,
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(seconds: AppConstants.timeOut),
      sendTimeout: const Duration(seconds: AppConstants.timeOut),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
