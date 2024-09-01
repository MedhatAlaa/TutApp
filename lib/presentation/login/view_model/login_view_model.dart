import 'dart:async';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import '../../../domain/usecase/login_usecase.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
  StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
  StreamController<String>.broadcast();
  final StreamController _areAllInputValidStreamController =
  StreamController<void>.broadcast();

  final StreamController isUserLoggedInSuccessfullyStreamController =
  StreamController<bool>();

  var loginObject = LoginObject('', '');

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  /// Login Inputs
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreAllInputValid => _areAllInputValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputValid.add(null);
  }

  @override
  login() async {
    inputState
        .add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.userName, loginObject.password),
    )).fold(
          (failure) =>
      {
        inputState
            .add(ErrorState(StateRenderType.popupErrorState, failure.message)),
      },
          (data) => {
      inputState.add(ContentState()),
      isUserLoggedInSuccessfullyStreamController.add(true),
    },
    );
  }

  /// Login Outputs
  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordStreamController.stream
          .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid =>
      _userNameStreamController.stream
          .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outAreAllInputValid =>
      _areAllInputValidStreamController.stream.map((_) => _areAllInputValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _areAllInputValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllInputValid;
}
