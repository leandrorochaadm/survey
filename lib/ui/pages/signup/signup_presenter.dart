import '../../../ui/helpers/errors/errors.dart';

abstract class SignUpPresenter {
  Stream<UIError> get nameErrorStream;
  Stream<UIError> get emailErrorStream;
  Stream<UIError> get passwordErrorStream;
  Stream<UIError> get passwordConfirmationErrorStream;
  Stream<UIError> get mainErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateName(String email);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String password);
  void signUp();
}
