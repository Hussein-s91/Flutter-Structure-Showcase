import 'api_client.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  static final ApiProvider _singleton = ApiProvider._internal();
  final Dio dio = Dio();
  static CancelToken cancelToken = CancelToken();

      factory ApiProvider() {
    return _singleton;
  }

  ApiProvider._internal();

  ApiClient getClient() {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    dio.options.headers['Accept'] = '*/*';
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    dio.options.headers['Connection'] = 'keep-alive';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.followRedirects = true;
    dio.options.validateStatus = (status) {
      return status! < 300;
    };

    return ApiClient(dio);
  }
}

class CancelReq{
  CancelToken cancelToken = CancelToken();
}