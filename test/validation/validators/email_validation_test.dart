import 'package:survey/validation/validators/validators.dart';
import 'package:test/test.dart';

main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('test@test.com'), null);
  });

  test('Shold return error is email is invalid', () {
    expect(sut.validate('test'), 'Campo inválido');
  });
}
