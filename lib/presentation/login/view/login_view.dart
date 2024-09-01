import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';
import '../../../app/app_prefs.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manger.dart';
import '../../resources/routes_manger.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _userPasswordController.addListener(
        () => _viewModel.setPassword(_userPasswordController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: AppBar(
        backgroundColor: ColorManger.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManger.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (BuildContext context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(AppPaddingManger.padding14),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizeManger.size6,
              ),
              const Image(
                image: AssetImage(ImageAssetsManger.splashLogo),
              ),
              const SizedBox(
                height: AppSizeManger.size20,
              ),

              /// User Name Form Filed
              StreamBuilder<bool>(
                  stream: _viewModel.outIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: AppStringManger.username.tr(),
                        labelText: AppStringManger.username.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStringManger.username.tr(),
                      ),
                    );
                  }),
              const SizedBox(
                height: AppSizeManger.size20,
              ),

              /// Password Form Filed
              StreamBuilder<bool>(
                stream: _viewModel.outIsPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _userPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: AppStringManger.password.tr(),
                      labelText: AppStringManger.password.tr(),
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStringManger.passwordError.tr(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: AppSizeManger.size20,
              ),

              /// Login Button
              StreamBuilder<bool>(
                stream: _viewModel.outAreAllInputValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSizeManger.size40,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _viewModel.login();
                            }
                          : null,
                      child:  Text(AppStringManger.login.tr()),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: AppSizeManger.size20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                          context,
                          Routes.forgetPasswordRoute,
                        );
                      },
                      child: Text(
                        AppStringManger.forgetPassword.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                          context,
                          Routes.registerRoute,
                        );
                      },
                      child: Text(
                        AppStringManger.registerText.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
