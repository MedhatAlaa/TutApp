import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/models.dart';

import '../data/network/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequests);

  Future<Either<Failure, HomeObject>> getHomeData();

  Future<Either<Failure, StoreDetails>> getStoreDetails();
}
