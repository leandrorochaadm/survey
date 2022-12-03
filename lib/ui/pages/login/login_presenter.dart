abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorController;

  void validateEmail(String email);
  void validatePassword(String password);
}
