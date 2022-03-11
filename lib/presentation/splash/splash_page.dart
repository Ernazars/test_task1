import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task1/injection/init_get.dart';

import 'splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<SplashCubit>(),
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            return const Center(child: Text("Test task"));
          },
        ),
      ),
    );
  }
}
