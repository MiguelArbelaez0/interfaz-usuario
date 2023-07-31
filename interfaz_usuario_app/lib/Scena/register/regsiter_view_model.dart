import '../../data/models/user_data.dart';
import '../../data/repository/user/user_repository.dart';

abstract class IRegisterViewModel {
  void onGetUser(UserData userData);
  void onCreateComplete(UserData userData);
  void onError(String error);
}

class RegisterViewModel implements IUserRepository {
  late IRegisterViewModel iRegisterViewModel;
  late UserRepository userRepository;
  RegisterViewModel(this.iRegisterViewModel) {
    userRepository = UserRepository(this);
  }

  void createUser(UserData userData) {
    userRepository.createUser(userData);
  }

  @override
  void onCreateComplete(UserData userData) {
    iRegisterViewModel.onCreateComplete(userData);
  }

  @override
  void onError(String error) {
    // TODO: implement onError
    iRegisterViewModel.onError(error);
  }

  @override
  void onGetUser(UserData userData) {
    // TODO: implement onGetUser
    iRegisterViewModel.onGetUser(userData);
  }
}
