import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/app/my_app.dart';
import 'package:tut_app/presentation/resources/language_manger.dart';

import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PASS_LOCALIZATION,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
