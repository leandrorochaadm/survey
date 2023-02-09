import 'translation.dart';

class PtBr implements Translations {
  String get msgInvalidField => 'Campo inválido';
  String get msgInvalidCredentials => 'Credenciais inválidas';
  String get msgRequiredField => 'Campo obrigatório';
  String get msgUnexpected => 'Algo errado aconteceu. Tente novamente';

  @override
  String get addAccount => 'Criar Conta';
  String get confirmPassword => 'Confirmar senha';
  String get name => 'Nome';
  String get password => 'Senha';
  String get login => 'Login';
  String get email => 'Email';
}
