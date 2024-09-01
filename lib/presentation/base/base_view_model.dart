import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {
  final _inputStreamController = BehaviorSubject<FlowState>();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
