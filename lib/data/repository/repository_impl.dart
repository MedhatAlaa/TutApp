import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/base_repository.dart';
import 'package:tut_app/domain/models.dart';

import '../network/error_handlar.dart';

class RepositoryImpl implements BaseRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequests) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequests);
        if (response.status == AppInternalServer.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(AppInternalServer.FAILURE,
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHomeData();
          if (response.status == AppInternalServer.SUCCESS) {
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(
              Failure(AppInternalServer.FAILURE,
                  response.message ?? ResponseMessage.DEFAULT),
            );
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getStoreDetails();
        if (response.status == AppInternalServer.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left (DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
