import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'data/hive_adapters/user_hive_type.dart';
import 'navigation/app_router.gr.dart';
import 'injection/init_get.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
      Hive.registerAdapter(UserHiveTypeAdapter());
      await configureDependencies();
      await GetIt.I.allReady();
      runApp(TestTask());
    },
    (error, stack) => log("error: $error\n\n stack: $stack"),
  );
}

class TestTask extends StatelessWidget {
  TestTask({Key? key}) : super(key: key);
  final _appRouter = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
