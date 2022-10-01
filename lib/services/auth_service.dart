import '../core/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/print.dart';
import '../core/utils.dart';
import '../routes.dart';

final authService = Provider((ref) => AuthService(ref));

class AuthService {
  final Ref ref;
  AuthService(this.ref);

  DioService get _dio => ref.watch(dioService);

  Future<Response?> login({String? username, String? password}) async {
    try {
      final res = await _dio.post('/Account/customer/auth',
          data: {"userName": username, "password": password});
      Print.log(res);
      return res;
    } catch (e) {
      if (e is DioError) {
        final code = e.response!.statusCode!;
        if (code == 422) {
          Utils.show.toast('Invalid data');
        }
        if (code == 400) {
          Utils.show.toast("Credentials doesn't match.");
        }
        if (code == 401) {
          Utils.show.toast("Something went wrong.");
          Routes.router.push("/login");
        }
        return e.response;
      }
      rethrow;
    }
  }
}
