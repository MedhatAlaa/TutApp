import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view.dart';
import 'package:tut_app/presentation/login/view/login_view.dart';
import 'package:tut_app/presentation/onBoarding/view/onBoarding_view.dart';
import 'package:tut_app/presentation/register/register_view.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/view/store_details_view.dart';
import '../../app/di.dart';
import '../main/main_view.dart';
import '../main/pages/settings/settings_page.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String onBoardingRoute = '/onBoarding';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String homeRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
  static const String settingsRoute = '/settings';
}

class RouteGenerator {
  static Route<dynamic> getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.homeRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStringManger.noRouteFound.tr(),
          ),
        ),
        body:  Center(
            child: Text(
          AppStringManger.noRouteFound.tr(),
        )),
      ),
    );
  }
}
