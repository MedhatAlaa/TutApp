import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

import '../base_repository.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final BaseRepository _baseRepository;

  HomeUseCase(this._baseRepository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _baseRepository.getHomeData();
  }
}
