import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/base_repository.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final BaseRepository _baseRepository;

  LoginUseCase(this._baseRepository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _baseRepository.login(LoginRequests(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
