import 'package:stepfront_api/models.dart/profile_model.dart';

import '../core/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/print.dart';
import '../core/utils.dart';
import '../routes.dart';

final userService = Provider((ref) => UserService(ref));

class UserService {
  final Ref ref;
  UserService(this.ref);

  DioService get _dio => ref.watch(dioService);

  Future<Response?> fetchData() async {
    try {
      final res = await _dio.get('/Account/customer/profile');
      Print.log(res);
      return res;
    } catch (e) {
      if (e is DioError) {
        Print.log(e.requestOptions.headers);
        final code = e.response!.statusCode!;
        if (code == 422) {
          Utils.show.toast('invalid-data');
        }
        if (code == 400) {
          Utils.show.toast('account-is-suspended');
        }
        if (code == 401) {
          Utils.show.toast("your-phone-is-linked");
          Routes.router.push("/");
        }
      }
      rethrow;
    }
  }

  Future<bool> updateProfile(ProfileModel data) async {
   
    try {
      final res = await _dio.post('Account/update', data: {
        "name": data.name,
        "surname": data.surname,
        "email": data.email,
        "phoneNumber": data.phoneNumber
      });
      Print.log(res);
      return res.data['succeeded'] as bool;
    } catch (e) {
      if (e is DioError) {
      Print.log(e.response);
        Print.log(e.requestOptions.headers);
        final code = e.response!.statusCode!;
        if (code == 422) {
          Utils.show.toast('invalid-data');
        }
        if (code == 400) {
          Utils.show.toast('account-is-suspended');
        }
        if (code == 401) {
          Utils.show.toast("your-phone-is-linked");
          Routes.router.push("/");
        }
      }
      rethrow;
    }
  }
}
