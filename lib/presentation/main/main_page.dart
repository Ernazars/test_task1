import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_task1/navigation/app_router.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Главная",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Профиль",
            ),
          ],
        );
      },
    );
  }
}
