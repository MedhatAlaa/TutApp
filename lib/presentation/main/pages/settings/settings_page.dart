import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/presentation/resources/assets_manger.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../../../app/di.dart';
import '../../../resources/language_manger.dart';
import '../../../resources/routes_manger.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPaddingManger.padding12),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              ImageAssetsManger.changeLanguage,
              height: AppSizeManger.size20,
            ),
            title: Text(
              AppStringManger.changeLanguage.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: ColorManger.primary,
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageAssetsManger.contactUs,
              height: AppSizeManger.size20,
            ),
            title: Text(
              AppStringManger.contactUs.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: ColorManger.primary,
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageAssetsManger.inviteFriends,
              height: AppSizeManger.size20,
            ),
            title: Text(
              AppStringManger.inviteYourFriends.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: ColorManger.primary,
            ),
            onTap: () {
              _inviteYourFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageAssetsManger.logout,
              height: AppSizeManger.size20,
            ),
            title: Text(
              AppStringManger.logout.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }

  _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs() {
    ///  todo share app with url
  }

  _inviteYourFriends() {
    /// todo share app with friends
  }

  _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
