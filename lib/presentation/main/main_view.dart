import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/main/pages/home/view/home_view.dart';
import 'package:tut_app/presentation/main/pages/notification/notification_page.dart';
import 'package:tut_app/presentation/main/pages/services/services_page.dart';
import 'package:tut_app/presentation/main/pages/settings/settings_page.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  String title = AppStringManger.home.tr();
  List<Widget> pages = [
    const HomePage(),
    const ServicesPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];
  List<String> titles = [
    AppStringManger.home.tr(),
    AppStringManger.search.tr(),
    AppStringManger.notification.tr(),
    AppStringManger.settings.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        iconTheme: IconThemeData(color: ColorManger.primary),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: AppSizeManger.size0,
        backgroundColor: ColorManger.white,
        selectedItemColor: ColorManger.primary,
        unselectedItemColor: ColorManger.lightGrey,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home_outlined,
            ),
            label: AppStringManger.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.design_services_rounded,
            ),
            label: AppStringManger.search.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.notifications_outlined,
            ),
            label: AppStringManger.notification.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
            ),
            label: AppStringManger.settings.tr(),
          ),
        ],
      ),
    );
  }

  onTap(int index) {
    setState(() {
      currentIndex = index;
      title = titles[currentIndex];
    });
  }
}
