import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/presentation/resources/assets_manger.dart';
import 'package:tut_app/presentation/resources/color_manger.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/styles_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

enum StateRenderType {
  /// popup states
  popupLoadingState,
  popupErrorState,

  /// full screen states
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  /// content states
  contentState,
}

class StateRenderer extends StatelessWidget {
  final StateRenderType stateRenderType;
  final String message;
  final String title;
  final Function retryActionFunction;

  const StateRenderer(
      {super.key,
      required this.stateRenderType,
      this.message = AppStringManger.loading,
      this.title = '',
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRenderType) {
      case StateRenderType.popupLoadingState:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssetsManger.loading)]);
      case StateRenderType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssetsManger.error),
          _getMessage(message),
          _getRetryButton(context, AppStringManger.ok.tr()),
        ]);
      case StateRenderType.fullScreenLoadingState:
        return _getColumnItem([
          _getAnimatedImage(JsonAssetsManger.loading),
          _getMessage(message),
        ]);
      case StateRenderType.fullScreenErrorState:
        return _getColumnItem([
          _getAnimatedImage(JsonAssetsManger.error),
          _getMessage(message),
          _getRetryButton(context, AppStringManger.retryAgain.tr()),
        ]);
      case StateRenderType.fullScreenEmptyState:
        return _getColumnItem([
          _getAnimatedImage(JsonAssetsManger.empty),
          _getMessage(message),
        ]);
      case StateRenderType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeManger.size14),
      ),
      backgroundColor: Colors.transparent,
      elevation: AppSizeManger.size1_5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizeManger.size14),
          color: ColorManger.white,
          shape: BoxShape.rectangle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
            )
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _getColumnItem(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSizeManger.size100,
      width: AppSizeManger.size100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddingManger.padding12),
        child: Text(
          message,
          style: getRegularStyle(
            color: ColorManger.black,
            fontSize: AppSizeManger.size18,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(BuildContext context, String buttonTitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddingManger.padding16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRenderType == StateRenderType.fullScreenErrorState) {
                retryActionFunction
                    .call(); // to call the API function again to retry
              } else {
                Navigator.of(context)
                    .pop(); // popup state error so we need to dismiss the dialog
              }
            },
            child: Text(buttonTitle),
          ),
        ),
      ),
    );
  }
}
