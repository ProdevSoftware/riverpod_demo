import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final apiClientProvider = Provider((ref) => ApiClient());

class ApiClient {
  late Dio dio;

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.escuelajs.co/api/v1/',
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options)
      ..interceptors.addAll([
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          responseBody: true,
        ),
      ]);
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queries,
  }) async {
    return dio.get(path,
        queryParameters: queries,
        options: Options(
          contentType: 'application/json',
        ));
  }

  Future<Response<dynamic>> post(
    String path,
    Map<String, dynamic> data,
  ) async {
    return dio.post(
      path,
      data: FormData.fromMap(data),
    );
  }
}
