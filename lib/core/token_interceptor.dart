import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/token_provider.dart';

class TokenInterceptor extends Interceptor {
  final ProviderRef ref;
  TokenInterceptor(this.ref);


  @override
  void onRequest(options, handler) async {
    // PackageInfo packageName = await PackageInfo.fromPlatform();
    options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ref.watch(tokenProvider).value}'
    };

    handler.next(options);
  }
}