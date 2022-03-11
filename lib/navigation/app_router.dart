import 'package:auto_route/auto_route.dart';
import 'package:test_task1/presentation/main/home/home_page.dart';
import 'package:test_task1/presentation/main/main_page.dart';
import 'package:test_task1/presentation/main/profile/profile_page.dart';
import 'package:test_task1/presentation/registration/registration_page.dart';
import 'package:test_task1/presentation/authorization/authorization_page.dart';
import 'package:test_task1/presentation/splash/splash_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: AuthorizationPage),
    AutoRoute(page: RegistrationPage),
    AutoRoute(page: MainPage, children: [
      AutoRoute(page: HomePage, initial: true),
      AutoRoute(page: ProfilePage),
    ])
  ],
)
class $AppRouter {}
