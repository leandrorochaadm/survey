import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  String validade({@required String field, @required String value});
}

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({@required this.validation});

  void validadeEmail(String email) {
    validation.validade(field: 'email', value: email);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  StreamLoginPresenter sut;
  ValidationSpy validation;
  String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call Validation with correct email', () {
    sut.validadeEmail(email);

    verify(validation.validade(field: 'email', value: email)).called(1);
  });
}
