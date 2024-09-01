import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/base_repository.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:tut_app/presentation/store_details/view_model/store_details_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final shardPrefs = await SharedPreferences.getInstance();

  /// Shard Prefs Instance
  instance.registerLazySingleton<SharedPreferences>(() => shardPrefs);

  /// App Prefs Instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  /// Network Info Instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  /// Dio Factory Instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  /// App Service Instance
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  /// Remote Data Instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  /// Local Data Instance
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  /// Repository Instance
  instance.registerLazySingleton<BaseRepository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}

