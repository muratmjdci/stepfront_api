import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:stepfront_api/pages/splash_screen.dart';
import 'pages/home_page.dart';

/// We're using flutter team's official navigation package named go_router
///
/// https://gorouter.dev/
///
/// You can check the documentation to learn how to navigate!
///
/// Example: context.push(Routes.login);
///
/// without context: Routes.router.push(Routes.login);
class Routes {
  /// Gets current context globally from navigator;
  static BuildContext get context => Routes.router.navigator!.context;

  /// Giving names to the routes to prevent hardcoding while routing
  static const splashScreen = '/';
  static const homePage = '/home';

  /// After we create the page and path, you can add the route to the navigator
  static final router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: splashScreen,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: homePage,
        builder: (_, __) => const HomePage(),
      ),
    ],
  );
}
