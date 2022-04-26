import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/data/http/http.dart';
import 'package:survey/data/usecases/usecases.dart';
import 'package:survey/domain/helpers/helpers.dart';
import 'package:survey/domain/usecases/usecases.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;
  AuthenticationParams params;

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
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient correct values', () async {
    // action
    await sut.auth(params);

    // assert
    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {'email': params.email, 'password': params.secret},
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    // arrange
    mockHttpError(HttpError.badRequest);

    // action
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 500', () async {
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient return 401',
      () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient return 200', () async {
    // arrange
    final validData = mockValidData();
    mockHttpData(validData);

    // action
    final account = await sut.auth(params);

    // assert
    expect(account.token, validData['accessToken']);
  });

  test('Should UnexpectedError if HttpClient return 200 with invalid data ',
      () async {
    // arrange
    mockHttpData({'invalid_key': 'invalid_value'});

    // action
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
