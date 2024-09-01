import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/base_repository.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  final BaseRepository _baseRepository;

  StoreDetailsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await _baseRepository.getStoreDetails();
  }
}
