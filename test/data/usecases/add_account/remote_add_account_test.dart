import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/data/http/http.dart';
import 'package:survey/data/usecases/usecases.dart';
import 'package:survey/domain/helpers/helpers.dart';
import 'package:survey/domain/usecases/usecases.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAddAccount sut;
  HttpClientSpy httpClient;
  String url;
  AddAccountParams params;

  Map mockValidData() => {
        'accessToken': faker.guid.guid(),
        'name': faker.person.name(),
      };

  PostExpectation mockResquest() => when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body')));

  void mockHttpData(Map data) {
    mockResquest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockResquest().thenThrow(error);
  }

  setUp(() {
    // arrange
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
    params = AddAccountParams(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      passwordConfirmation: faker.internet.password(),
    );

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient correct values', () async {
    // action
    await sut.add(params);

    // assert
    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'passwordConfirmation': params.passwordConfirmation,
      },
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    // arrange
    mockHttpError(HttpError.badRequest);

    // action
    final future = sut.add(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if HttpClient return 200', () async {
    // arrange
    final validData = mockValidData();
    mockHttpData(validData);

    // action
    final account = await sut.add(params);

    // assert
    expect(account.token, validData['accessToken']);
  });

  test('Should UnexpectedError if HttpClient return 200 with invalid data ',
      () async {
    // arrange
    mockHttpData({'invalid_key': 'invalid_value'});

    // action
    final future = sut.add(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
