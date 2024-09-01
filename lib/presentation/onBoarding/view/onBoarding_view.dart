import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/onBoarding/view_model/onboarding_view_model.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../../app/di.dart';
import '../../resources/assets_manger.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _viewModel.outputsSliderViewObject,
        builder: (context, snapshot) => onBoardingDesign(snapshot.data));
  }

  Widget onBoardingDesign(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container(
        color: ColorManger.error,
      );
    } else {
      return Scaffold(
        backgroundColor: ColorManger.white,
        appBar: AppBar(
          backgroundColor: ColorManger.white,
          elevation: AppSizeManger.size0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorManger.white,
          ),
          title: const Text('On Boarding'),
        ),
        body: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemCount: sliderViewObject.numOfSlides,
          itemBuilder: (context, index) =>
              pageControllerItem(sliderViewObject.sliderObject),
        ),
        bottomSheet: Container(
          color: ColorManger.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(AppSizeManger.size8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.loginRoute,
                      );
                    },
                    child: Text(
                      AppStringManger.skip.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              Container(
                color: ColorManger.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Left Arrow
                    IconButton(
                      onPressed: () {
                        _pageController.animateToPage(
                          _viewModel.goPrevious(),
                          duration: const Duration(
                              milliseconds: AppIntManger.durationPage),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: ColorManger.white,
                      ),
                    ),

                    /// Middle Circles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                          Padding(
                            padding: const EdgeInsets.all(AppSizeManger.size8),
                            child: _getPopperCircle(
                              i,
                              sliderViewObject,
                            ),
                          ),
                      ],
                    ),

                    /// Right Arrow
                    IconButton(
                      onPressed: () {
                        _pageController.animateToPage(
                          _viewModel.goNext(),
                          duration: const Duration(
                              milliseconds: AppIntManger.durationPage),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: ColorManger.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget pageControllerItem(SliderObject sliderObject) => Padding(
        padding: const EdgeInsets.all(AppPaddingManger.padding16),
        child: Column(
          children: [
            const SizedBox(
              height: AppSizeManger.size40,
            ),
            Text(
              sliderObject.title,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSizeManger.size12,
            ),
            Text(
              sliderObject.subTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSizeManger.size40,
            ),
            SvgPicture.asset(sliderObject.image),
          ],
        ),
      );

  Widget _getPopperCircle(int index, SliderViewObject sliderViewObject) {
    if (index == sliderViewObject.currentIndex) {
      return const Image(
        image: AssetImage(ImageAssetsManger.onBoardingHoloCirclePng),
      );
    }
    return const Image(
      image: AssetImage(ImageAssetsManger.onBoardingSolidCirclePng),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
