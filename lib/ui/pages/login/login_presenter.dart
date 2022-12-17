abstract class LoginPresenter {
  Stream get isFormValidStream;
  Stream get emailErrorStream;
  Stream get passwordErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}
