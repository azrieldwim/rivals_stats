import 'package:dio/dio.dart';
import 'api_config.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'x-api-key': ApiConfig.apiKey, 'Accept': 'application/json'},
    ),
  );

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
