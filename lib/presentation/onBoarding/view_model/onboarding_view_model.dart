import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/presentation/resources/assets_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import '../../../domain/models.dart';
import '../../base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late List<SliderObject> _list;
  int currentIndex = 0;

  /// On Boarding Inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    postDataToView();
  }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    postDataToView();
  }

  @override
  Sink get inputsSliderViewObject => _streamController.sink;

  /// On Boarding Outputs
  @override
  Stream<SliderViewObject> get outputsSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  /// On Boarding Functions
  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStringManger.onBoardingTitle1.tr(),
          AppStringManger.onBoardingSubTitle1.tr(),
          ImageAssetsManger.onBoardingLogo1,
        ),
        SliderObject(
          AppStringManger.onBoardingTitle2.tr(),
          AppStringManger.onBoardingSubTitle2.tr(),
          ImageAssetsManger.onBoardingLogo2,
        ),
        SliderObject(
          AppStringManger.onBoardingTitle3.tr(),
          AppStringManger.onBoardingSubTitle3.tr(),
          ImageAssetsManger.onBoardingLogo3,
        ),
        SliderObject(
          AppStringManger.onBoardingTitle4.tr(),
          AppStringManger.onBoardingSubTitle4.tr(),
          ImageAssetsManger.onBoardingLogo4,
        ),
      ];

  void postDataToView() {
    _streamController.sink.add(
      SliderViewObject(
        _list[currentIndex],
        currentIndex,
        _list.length,
      ),
    );
  }

  @override
  int goNext() {
    int nextIndex = ++currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }
}

abstract class OnBoardingViewModelInputs {
  Sink get inputsSliderViewObject;

  void onPageChanged(int index);

  int goPrevious();

  int goNext();
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputsSliderViewObject;
}
