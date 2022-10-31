import 'dart:async';

import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/presentation/protocols/validation.dart';
import 'package:test/test.dart';

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({@required this.validation});

  void validadeEmail(String email) {
    _state.emailError = validation.validade(field: 'email', value: email);
    _controller.add(_state);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  StreamLoginPresenter sut;
  ValidationSpy validation;
  String email;

  PostExpectation<String> mockValidationCall(String field) =>
      when(validation.validade(
        field: field == null ? anyNamed('field') : field,
        value: anyNamed('value'),
      ));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validadeEmail(email);

    verify(validation.validade(field: 'email', value: email)).called(1);
  });

  test('Should emit error if validation fails', () {
    mockValidation(value: 'error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validadeEmail(email);
  });
}
