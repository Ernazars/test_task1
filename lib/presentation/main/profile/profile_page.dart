import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task1/injection/init_get.dart';
import 'package:test_task1/presentation/main/profile/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt<ProfileCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Профиль"),
            actions: [
              IconButton(
                onPressed: () => showExitDialog(
                  context,
                  context.read<ProfileCubit>(),
                ),
                icon: const Icon(Icons.logout_rounded),
              ),
            ],
          ),
          body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  logoutFailed: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  });
            },
            buildWhen: (previous, current) => current.maybeWhen(
              orElse: () => true,
              logoutFailed: (_) => false,
            ),
            builder: (context, state) => state.maybeWhen(
              orElse: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              failed: (message) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message),
                  const SizedBox(height: 24),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("Попробовать еще раз")),
                ],
              ),
              data: (user) => Column(
                children: [
                  ProfileFieldWidget(
                    title: "Имя: ",
                    value: user.name,
                  ),
                  ProfileFieldWidget(
                    title: "email: ",
                    value: user.email,
                  ),
                  ProfileFieldWidget(
                    title: "Дата регистрации: ",
                    value: user.regDate.toString(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> showExitDialog(BuildContext context, ProfileCubit cubit) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Вы хотите выйти с учетной записи?"),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Нет"),
                      ),
                      const SizedBox(width: 48),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            cubit.logout();
                          },
                          child: const Text("Да")),
                    ],
                  ),
                ],
              ),
            )));
  }
}

class ProfileFieldWidget extends StatelessWidget {
  const ProfileFieldWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(title,
                style: const TextStyle(
                    color: Color.fromARGB(255, 90, 90, 90),
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
          Expanded(
            flex: 2,
            child: Text(value,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
