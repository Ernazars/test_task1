import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task1/core/input_validation_mixin.dart';
import 'package:test_task1/injection/init_get.dart';
import 'package:test_task1/presentation/widgets/app_input_widget.dart';

import 'registration_cubit.dart';

class RegistrationPage extends StatelessWidget with InputValidationMixin {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Регистрация")),
      body: BlocProvider(
        create: (context) => getIt<RegistrationCubit>(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppInputWidget(
                      controller: emailController,
                      hintText: "example@domain.com",
                      labelText: "Введите email",
                      validator: (email) => isEmailValid(email),
                    ),
                    const SizedBox(height: 24),
                    AppInputWidget(
                      controller: nameController,
                      labelText: "Введите имя",
                      validator: (name) => isNameValid(name),
                    ),
                    const SizedBox(height: 24),
                    AppInputWidget(
                      controller: passwordController,
                      labelText: "Введите пароль",
                      maxLength: 6,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      validator: (password) => isPasswordValid(password),
                    ),
                    const SizedBox(height: 24),
                    AppInputWidget(
                      controller: confirmPasswordController,
                      labelText: "Повторите пароль",
                      maxLength: 6,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      validator: (password) => isPasswordValid(password),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              BlocConsumer<RegistrationCubit, RegistrationState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    failed: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) => state.maybeWhen(
                    orElse: () => ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (confirmPasswordController.text ==
                                  passwordController.text) {
                                context
                                    .read<RegistrationCubit>()
                                    .toRegistration(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Пароли не совпадают"),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text("Зарегистрироваться"),
                        ),
                    registration: () =>
                        const CircularProgressIndicator.adaptive()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
