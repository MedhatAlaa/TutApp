import 'package:tut_app/app/constants.dart';
import 'package:tut_app/app/extension.dart';
import 'package:tut_app/domain/models.dart';
import '../responses/responses.dart';

/// login page mapper
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? AppConstants.emptyString,
      this?.name.orEmpty() ?? AppConstants.emptyString,
      this?.numOfNotification.orZero() ?? AppConstants.emptyInteger,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? AppConstants.emptyString,
      this?.email.orEmpty() ?? AppConstants.emptyString,
      this?.link.orEmpty() ?? AppConstants.emptyString,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

/// home page mapper
extension ServicesResponseExtension on ServicesResponse? {
  Service toDomain() {
    return Service(
      this?.id.orZero() ?? AppConstants.emptyInteger,
      this?.title.orEmpty() ?? AppConstants.emptyString,
      this?.image.orEmpty() ?? AppConstants.emptyString,
    );
  }
}

extension BannerResponseExtension on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id.orZero() ?? AppConstants.emptyInteger,
      this?.title.orEmpty() ?? AppConstants.emptyString,
      this?.image.orEmpty() ?? AppConstants.emptyString,
      this?.link.orEmpty() ?? AppConstants.emptyString,
    );
  }
}

extension StoreResponseExtension on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id.orZero() ?? AppConstants.emptyInteger,
      this?.title.orEmpty() ?? AppConstants.emptyString,
      this?.image.orEmpty() ?? AppConstants.emptyString,
    );
  }
}

extension HomeResponseExtension on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((servicesResponse) => servicesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannerResponse) => bannerResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    List<Store> stores =
        (this?.data?.stores?.map((storeResponse) => storeResponse.toDomain()) ??
                const Iterable.empty())
            .cast<Store>()
            .toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

/// Store Details mapper
extension StoreDatailsExension on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      this?.image?.orEmpty() ?? AppConstants.emptyString,
      this?.id?.orZero() ?? AppConstants.emptyInteger,
      this?.title?.orEmpty() ?? AppConstants.emptyString,
      this?.details?.orEmpty() ?? AppConstants.emptyString,
      this?.services?.orEmpty() ?? AppConstants.emptyString,
      this?.about?.orEmpty() ?? AppConstants.emptyString,
    );
  }
}
