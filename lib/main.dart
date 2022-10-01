import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/styles.dart';
import 'routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    /// You can test your app's responsiveness by uncommenting this line
    // DevicePreview(builder: (_) => const ProviderScope(child: MyApp())),
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: Routes.router.routeInformationParser,
      routerDelegate: Routes.router.routerDelegate,
      builder: DevicePreview.appBuilder,
      useInheritedMediaQuery: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        iconTheme: IconThemeData(color: S.colors.text),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
    );
  }
}
