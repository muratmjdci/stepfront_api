// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:stepfront_api/provider/token_provider.dart';
import 'package:stepfront_api/provider/user_provider.dart';
import 'package:stepfront_api/widgets/custom_text_field.dart';
import '../core/styles.dart';
import '../core/utils.dart';
import '../routes.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController(text: "apitest@testapi.com");
    final password = useTextEditingController(text: "test1234");

    return Scaffold(
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 15,
          children: [
            Column(
              children: [
                Text(
                  "Welcome back",
                  style: TextStyle(
                      color: S.colors.text.withOpacity(.9),
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Enter your credentials to login",
                  style: TextStyle(
                    color: S.colors.text.withOpacity(.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            CustomTextField(
              controller: email,
              hintText: "E-mail",
            ),
            CustomTextField(
              controller: password,
              hintText: "Password",
              isPassword: true,
            ),
            ElevatedButton(
                onPressed: () async {
                  Utils.show.dialog(
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [CircularProgressIndicator.adaptive()],
                    )),
                    hasBorder: false,
                  );

                  await ref.watch(tokenProvider.notifier).login(
                        username: email.text,
                        password: password.text,
                      );

                  if (ref.watch(tokenProvider).value!.isNotEmpty) {
                    await ref.watch(userProvider.notifier).fetchData();

                    if (isDialogOpen) Navigator.pop(context);
                    Utils.show.toast('Logged In successfully');
                    context.go(Routes.homePage);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: const Text("LogIn"))
          ],
        ),
      ),
    );
  }
}
