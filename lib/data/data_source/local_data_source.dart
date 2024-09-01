import 'package:tut_app/data/network/error_handlar.dart';

import '../responses/responses.dart';

const cacheHomeKey = "cacheHomeKey";
const cacheHomeInterval = 60000;

/// 1 minute cache time ;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl extends LocalDataSource {
  Map<String, CacheItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    CacheItem? cacheItem = cacheMap[cacheHomeKey];

    if (cacheItem != null && cacheItem.isValid(cacheHomeInterval)) {
      return cacheItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CacheItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CacheItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CacheItem(this.data);
}

extension CacheItemExtension on CacheItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isValid;
  }
}
