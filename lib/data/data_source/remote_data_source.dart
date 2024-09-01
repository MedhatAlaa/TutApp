import 'package:tut_app/data/network/requests.dart';

import '../network/app_api.dart';
import '../responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);

  Future<HomeResponse> getHomeData();

  Future<StoreDetailsResponse> getStoreDetails();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServiceClient.login(
      loginRequests.email,
      loginRequests.password,
    );
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHome();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    return await _appServiceClient.getStoreDetails();
  }
}
