import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/presentation/presenters/presenters.dart';
import 'package:survey/presentation/protocols/protocols.dart';
import 'package:test/test.dart';

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

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validadeEmail(email);
    sut.validadeEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validadeEmail(email);
    sut.validadeEmail(email);
  });
}
