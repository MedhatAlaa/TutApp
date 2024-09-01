/// On Boarding Models
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int currentIndex;
  int numOfSlides;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSlides);
}

/// Login Models
class Customer {
  String id;
  String name;
  int numOfNotification;

  Customer(this.id, this.name, this.numOfNotification);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

/// Home Models
class Service {
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;

  BannerAd(this.id, this.title, this.image, this.link);
}

class Store {
  int id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData? data;

  HomeObject(this.data);
}

/// Store Details Models
class StoreDetails {
  String image;
  int id;
  String title;
  String details;
  String services;
  String about;

  StoreDetails(
      this.image, this.id, this.title, this.details, this.services, this.about);
}
