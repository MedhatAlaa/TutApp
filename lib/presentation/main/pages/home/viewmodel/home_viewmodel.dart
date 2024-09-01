import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  final  _bannerStreamController =
      BehaviorSubject<List<BannerAd>>();
  final  _storeStreamController =
      BehaviorSubject<List<Store>>();
  final  _serviceStreamController =
      BehaviorSubject<List<Service>>();
  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start()async {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
      (failure) => {
        inputState.add(
          ErrorState(StateRenderType.fullScreenErrorState, failure.message),
        ),
      },
      (homeObject) => {
        inputState.add(ContentState()),
        inputBanners.add(homeObject.data?.banners),
        inputServices.add(homeObject.data?.services),
        inputStores.add(homeObject.data?.stores),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bannerStreamController.close();
    _storeStreamController.close();
    _serviceStreamController.close();
  }

  /// inputs
  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _serviceStreamController.sink;

  @override
  Sink get inputStores => _storeStreamController.sink;

  /// outputs
  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannerStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _serviceStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storeStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInputs {
  Sink get inputBanners;

  Sink get inputStores;

  Sink get inputServices;
}

abstract class HomeViewModelOutputs {
  Stream<List<BannerAd>> get outputBanners;

  Stream<List<Store>> get outputStores;

  Stream<List<Service>> get outputServices;
}
