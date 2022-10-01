import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/print.dart';
import '../services/auth_service.dart';

final tokenProvider = StateNotifierProvider<TokenNotifier, AsyncValue<String>>(
    (ref) => TokenNotifier(ref));

class TokenNotifier extends StateNotifier<AsyncValue<String>> {
  final Ref ref;
  TokenNotifier(this.ref) : super(const AsyncValue.data(''));

  Future<bool> login({String? username, String? password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final res = await ref.read(authService).login(
              username: username,
              password: password,
            );

        if (res?.data["succeeded"]) {
          return res?.data['data']['accessToken'];
        } else {
          return '';
        }
      },
    );
    if (state is! AsyncError) {
      return true;
    }
    Print.log(state);
    return false;
  }
}
