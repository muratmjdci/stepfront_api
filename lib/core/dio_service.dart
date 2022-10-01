import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepfront_api/core/token_interceptor.dart';

import 'constants.dart';
final dioService = Provider((ref) => DioService(ref));

class DioService {
  Dio get dio => _dio;
  final ProviderRef ref;
  DioService(this.ref) {
    _dio.interceptors.add(TokenInterceptor(ref));
  }

  static const _baseUrl = C.baseUrl;

  final _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: 12000,
    sendTimeout: 12000,
  ));


  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioError {
      rethrow;
    }
  }
  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioError {
      rethrow;
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data} ) async {
    try {
      return await _dio.put(path, data: data);
    } on DioError {
      rethrow;
    }
  } 
}