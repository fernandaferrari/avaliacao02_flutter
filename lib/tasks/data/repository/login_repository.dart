import 'package:imake/tasks/data/local/data_sources/login_data_provider.dart';
import 'package:imake/tasks/data/local/model/user_model.dart';

class LoginRepository {
  final LoginDataProvider loginDataProvider;

  LoginRepository({required this.loginDataProvider});

  Future<UserModel> findUser(String nome, String password) async {
    return await loginDataProvider.findUser(nome, password);
  }
}
