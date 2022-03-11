import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task1/core/input_validation_mixin.dart';
import 'package:test_task1/injection/init_get.dart';
import 'package:test_task1/presentation/authorization/authorization_cubit.dart';

import '../widgets/app_input_widget.dart';

class AuthorizationPage extends StatefulWidget {
  final String email;
  const AuthorizationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage>
    with InputValidationMixin {
  late TextEditingController emailController;
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Авторизация"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            AppInputWidget(
              controller: emailController,
              hintText: "example@domain.com",
              labelText: "email",
              validator: (email) => isEmailValid(email),
            ),
            const SizedBox(height: 24),
            AppInputWidget(
              controller: passwordController,
              labelText: "Пароль",
              maxLength: 6,
              obscureText: true,
              keyboardType: TextInputType.number,
              validator: (password) => isPasswordValid(password),
            ),
            const SizedBox(height: 48),
            BlocProvider(
              create: (context) => getIt<AuthorizationCubit>(),
              child: BlocConsumer<AuthorizationCubit, AuthorizationState>(
                listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      failed: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      });
                },
                builder: (context, state) => state.maybeWhen(
                    orElse: () => Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthorizationCubit>().login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                }
                              },
                              child: const Text("Войти"),
                            ),
                            const SizedBox(height: 48),
                            TextButton(
                              onPressed: () =>
                                  context.read<AuthorizationCubit>().toReg(),
                              child: const Text("Зарегистрироваться"),
                            )
                          ],
                        ),
                    authorization: () => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
