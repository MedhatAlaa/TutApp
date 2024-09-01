import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/presentation/resources/language_manger.dart';

const String prefsKeyLang = "PREFS_KRY_LANG";
const String prefsKeyOnBoardingViewed = "prefsKeyOnBoardingViewed";
const String prefsKeyIsUserLoggedIn = "prefsKeyIsUserLoggedIn";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.ENGLISH.getValue());
    } else {
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocal()async{
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  Future<void> setOnBoardingScreenViewed() {
    return _sharedPreferences.setBool(prefsKeyOnBoardingViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnBoardingViewed) ?? false;
  }

  Future<void> setUserLoggedIn() {
    return _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }
}
