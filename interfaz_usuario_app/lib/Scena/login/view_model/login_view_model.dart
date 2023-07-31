import '../../../data/models/login_data.dart';
import '../../../data/models/user_data.dart';
import '../../../data/repository/user/user_repository.dart';

abstract class ILoginViewModel {
  void onCompleteLogin(UserData userData);
  void onError(String error);
}

class LoginViewModel implements IUserRepository {
  late UserRepository userRepository;
  ILoginViewModel iLoginViewModel;
  LoginViewModel(this.iLoginViewModel) {
    userRepository = UserRepository(this);
  }

  void login(LoginData loginData) {
    userRepository.login(loginData);
  }

  @override
  void onCreateComplete(UserData userData) {
    // iLoginViewModel.onCompleteLogin(userData);
  }

  @override
  void onError(String error) {
    iLoginViewModel.onError(error);
  }

  @override
  void onGetUser(UserData userData) {
    iLoginViewModel.onCompleteLogin(userData);
  }
}
