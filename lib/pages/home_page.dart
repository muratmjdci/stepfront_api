// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:stepfront_api/models/profile_model.dart';
import 'package:stepfront_api/services/user_service.dart';
import 'package:stepfront_api/widgets/custom_text_field.dart';

import '../core/styles.dart';
import '../core/utils.dart';
import '../provider/user_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final canEdit = useState(true);
    var data = ref.watch(userProvider).value;
    final name = useTextEditingController(text: data?.name);
    final surname = useTextEditingController(text: data?.surname);
    final email = useTextEditingController(text: data?.email);
    final phoneNumber = useTextEditingController(text: data?.phoneNumber);

    final controller = useAnimationController();

    return GestureDetector(
      onTap: () => Utils.closeKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => canEdit.value = !canEdit.value,
            icon: Icon(
              Icons.edit,
              color: S.colors.text,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(runSpacing: 15, children: [
            FadeIn(
              child: CustomTextField(
                controller: name,
                readOnly: canEdit.value,
                hintText: "Name",
              ),
            ),
            FadeIn(
              child: CustomTextField(
                controller: surname,
                readOnly: canEdit.value,
                hintText: "Surname",
              ),
            ),
            FadeIn(
              child: CustomTextField(
                controller: email,
                readOnly: canEdit.value,
                hintText: "E-mail",
              ),
            ),
            FadeIn(
              child: CustomTextField(
                controller: phoneNumber,
                readOnly: canEdit.value,
                hintText: "Phone Number",
              ),
            ),
            if (!canEdit.value)
              UpdateButton(
                ref: ref,
                data: data,
                name: name,
                surname: surname,
                email: email,
                phoneNumber: phoneNumber,
                controller: controller,
              )
          ]),
        ),
      ),
    );
  }
}

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    Key? key,
    required this.data,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.controller,
    required this.ref,
  }) : super(key: key);
  final WidgetRef ref;
  final ProfileModel? data;
  final TextEditingController name;
  final TextEditingController surname;
  final TextEditingController email;
  final TextEditingController phoneNumber;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          data?.name = name.text;
          data?.surname = surname.text;
          data?.email = email.text;
          data?.phoneNumber = phoneNumber.text;
          Utils.show.dialog(
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator.adaptive(),
                ],
              ),
            ),
            hasBorder: false,
          );

          final res = await ref.watch(userService).updateProfile(data!);

          if (res) {
            if (isDialogOpen) Navigator.pop(context);
            Utils.show.dialog(
              Lottie.asset("assets/success.json",
                  repeat: false,
                  addRepaintBoundary: true,
                  controller: controller, onLoaded: (composition) {
                controller.duration = composition.duration;
                controller.forward();
              }),
              hasBorder: false,
            );

            Utils.show.toast(
              'Updated successfully',
              duration: controller.duration?.inSeconds,
            );

            controller.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                if (isDialogOpen) {
                  Navigator.pop(context);
                }
                if (Navigator.of(context).canPop()) {
                  Navigator.pop(context);
                }
                controller.clearStatusListeners();
                controller.reset();
              }
            });
          }
        },
        child: const Text('Update'),
      ),
    );
  }
}
