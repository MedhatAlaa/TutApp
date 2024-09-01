import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut_app/app/constants.dart';
import '../responses/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @GET("/home")
  Future<HomeResponse> getHome();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> getStoreDetails();
}
