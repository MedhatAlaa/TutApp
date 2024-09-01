import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponses {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;

  BaseResponses(this.status, this.message);
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotification")
  int? numOfNotification;

  CustomerResponse(this.id, this.name, this.numOfNotification);

  /// from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone, this.email, this.link);

  /// from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponses {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts) : super(0, '');

  /// from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

/// Home Responses

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  ServicesResponse(this.id, this.title, this.image);

  /// from json
  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "link")
  String? link;

  BannerResponse(this.id, this.title, this.image, this.link);

  /// from json
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  StoreResponse(this.id, this.title, this.image);

  /// from json
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServicesResponse>? services;
  @JsonKey(name: "banners")
  List<BannerResponse>? banners;
  @JsonKey(name: "stores")
  List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  /// from json
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponses {
  @JsonKey(name: "data")
  HomeDataResponse? data;

  HomeResponse(this.data) : super(0, '');

  /// from json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

/// Store Details Responses
@JsonSerializable()
class StoreDetailsResponse extends BaseResponses {
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "services")
  String? services;
  @JsonKey(name: "about")
  String? about;

  StoreDetailsResponse(
      this.image, this.id, this.title, this.details, this.services, this.about)
      : super(0, '');

  /// from json
  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}
