import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection/init_get.dart';
import 'sunrise_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
      ),
      body: BlocProvider(
        create: (context) => getIt<SunriseCubit>(),
        child: BlocBuilder<SunriseCubit, SunriseState>(
          builder: (context, state) => state.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              sunrise: (data) => RefreshIndicator(
                    onRefresh: () => context.read<SunriseCubit>().fetchData(),
                    child: ListView(
                      children: [
                        SunDataWidget(
                          title: "Восход",
                          value: data.sunrise,
                        ),
                        SunDataWidget(
                          title: "Закат",
                          value: data.sunset,
                        ),
                        SunDataWidget(
                          title: "Солнечный полдень",
                          value: data.solarNoon,
                        ),
                        SunDataWidget(
                          title: "Длина дня",
                          value: data.dayLength,
                        ),
                      ],
                    ),
                  ),
              failed: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Произошла ошибка: ${message}"),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<SunriseCubit>().fetchData(),
                          child: const Text("Попробовать еще раз"),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}

class SunDataWidget extends StatelessWidget {
  const SunDataWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: const TextStyle(fontStyle: FontStyle.italic),
              )),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w700),
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
