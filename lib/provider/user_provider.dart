import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stepfront_api/models.dart/profile_model.dart';
import 'package:stepfront_api/services/user_service.dart';

import '../core/print.dart';

final userProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<ProfileModel>>(
        (ref) => ProfileNotifier(ref));

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  final Ref ref;
  ProfileNotifier(this.ref)
      : super(
          AsyncValue.data(
            ProfileModel(
                email: '',
                languageCode: '',
                name: '',
                phoneNumber: '',
                profilePicturePath: '',
                surname: '',
                userId: ''),
          ),
        );

  Future<bool> fetchData() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final res = await ref.read(userService).fetchData();
        Print.log(res?.data['data']);
        return ProfileModel.fromJson(res?.data['data']);
      },
    );
    if (state is! AsyncError) {
      return true;
    }
    return false;
  }
  
}
