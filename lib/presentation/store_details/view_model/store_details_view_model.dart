import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();
  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  start() async {
    _getStoreDetails();
  }

  _getStoreDetails() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.fullScreenLoadingState));
    (await _storeDetailsUseCase.execute(Void)).fold(
        ((failure) => {
              inputState.add(
                ErrorState(
                    StateRenderType.fullScreenErrorState, failure.message),
              ),
            }), (data) async {
      inputState.add(ContentState());
      inputStoreDetails.add(data);
    });
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}

