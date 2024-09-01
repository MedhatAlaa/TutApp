import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/assets_manger.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/routes_manger.dart';
import '../resources/values_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  startDelay() {
    _timer = Timer(const Duration(seconds: AppIntManger.splashDelay), goNext);
  }

  goNext() {
    _appPreferences.isUserLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      } else {
        _appPreferences
            .isOnBoardingScreenViewed()
            .then((isOnBoardingScreenViewed) {
          if (isOnBoardingScreenViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssetsManger.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
