import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task1/navigation/app_router.gr.dart';

import 'init_get.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await $initGetIt(getIt);
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  @singleton
  AppRouter get appRouter => AppRouter();

  @singleton
  InternetConnectionChecker get internetConnectionChecker => InternetConnectionChecker();
}
