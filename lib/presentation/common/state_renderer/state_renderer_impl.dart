import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';

abstract class FlowState {
  StateRenderType getStateRendererType();

  String getMessage();
}

/// loading state
class LoadingState extends FlowState {
  StateRenderType stateRenderType;
  String? message;

  LoadingState({
    required this.stateRenderType,
    String message = AppStringManger.loading,
  });

  @override
  String getMessage() => message ?? AppStringManger.loading.tr();

  @override
  StateRenderType getStateRendererType() => stateRenderType;
}

/// error state
class ErrorState extends FlowState {
  StateRenderType stateRenderType;
  String message;

  ErrorState(this.stateRenderType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRendererType() => stateRenderType;
}

/// content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => AppConstants.emptyString;

  @override
  StateRenderType getStateRendererType() => StateRenderType.contentState;
}

/// empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRendererType() =>
      StateRenderType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryActionFunction,
  ) {
    switch (runtimeType) {
      case const (LoadingState):
        {
          if (getStateRendererType() == StateRenderType.popupLoadingState) {
            /// show popup
            showPopup(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRenderType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case const (ErrorState):
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRenderType.popupErrorState) {
            /// show popup
            showPopup(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRenderType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case const (ContentState):
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case const (EmptyState):
        {
          return StateRenderer(
            stateRenderType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: () {},
          );
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup(
      BuildContext context, StateRenderType stateRenderType, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) => StateRenderer(
            stateRenderType: stateRenderType,
            message: message,
            retryActionFunction: () {},
          ),
        ));
  }
}
