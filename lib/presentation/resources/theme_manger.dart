import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/font_manger.dart';
import 'package:tut_app/presentation/resources/styles_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    /// main Colors
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey,

    ///  CardView Theme
    cardTheme: CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.grey,
      elevation: AppSizeManger.size4,
      // margin: const EdgeInsets.all(AppMarginManger.margin12),
    ),

    ///  AppBar Theme
    appBarTheme: AppBarTheme(
      color: ColorManger.primary,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorManger.primary,
      ),
      titleTextStyle: getRegularStyle(
          color: ColorManger.white, fontSize: FontSizeManger.size16),
    ),

    /// Button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.lightPrimary,
      disabledColor: ColorManger.grey1,
    ),

    /// Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorManger.white,
        backgroundColor: ColorManger.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(AppSizeManger.size12),
        ),
        textStyle: getRegularStyle(
            color: ColorManger.white, fontSize: FontSizeManger.size16),
      ),
    ),

    /// Text Theme
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
          color: ColorManger.darkGrey, fontSize: FontSizeManger.size16),
      headlineMedium: getRegularStyle(
        color: ColorManger.darkGrey,
        fontSize: FontSizeManger.size14,
      ),
      headlineSmall: getRegularStyle(
          color: ColorManger.grey, fontSize: FontSizeManger.size14),
      titleLarge: getSemiBoldStyle(
          color: ColorManger.primary, fontSize: FontSizeManger.size16),
      displayLarge: getMediumStyle(
          color: ColorManger.primary, fontSize: FontSizeManger.size16),
      titleMedium: getBoldStyle(
          color: ColorManger.primary, fontSize: AppSizeManger.size14),
      titleSmall: getMediumStyle(
          color: ColorManger.lightGrey, fontSize: FontSizeManger.size14),
      bodySmall: getRegularStyle(
          color: ColorManger.primary, fontSize: FontSizeManger.size12),
    ),

    /// Input Decoration Theme (Text Form Field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppSizeManger.size6),
      labelStyle: getRegularStyle(
          color: ColorManger.grey, fontSize: FontSizeManger.size14),
      errorStyle: getRegularStyle(color: ColorManger.error),
      hintStyle: getRegularStyle(
          color: ColorManger.grey, fontSize: FontSizeManger.size14),

      /// Enabled Border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.lightGrey,
          width: AppSizeManger.size1_5,
        ),
        borderRadius: BorderRadius.circular(AppSizeManger.size8),
      ),

      /// Focused Border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSizeManger.size1_5,
        ),
        borderRadius: BorderRadius.circular(AppSizeManger.size8),
      ),

      ///  Error Border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.error,
          width: AppSizeManger.size1_5,
        ),
        borderRadius: BorderRadius.circular(AppSizeManger.size8),
      ),

      /// Focused Error Border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSizeManger.size1_5,
        ),
        borderRadius: BorderRadius.circular(AppSizeManger.size8),
      ),
    ),
  );
}
