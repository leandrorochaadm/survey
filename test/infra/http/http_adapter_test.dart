import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/data/http/http.dart';
import 'package:test/test.dart';

class ClienteSpy extends Mock implements Client {}

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: jsonBody);
    return response?.body?.isNotEmpty == true
        ? jsonDecode(response.body)
        : null;
  }
}

void main() {
  HttpAdapter sut;
  ClienteSpy client;
  String url;
  setUp(() {
    client = ClienteSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    PostExpectation mockRequest() =>
        when(client.post(any, headers: anyNamed('headers')));

    void mockResponse(int statusCode,
        {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      // action
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      //assert
      verify(
        client.post(url,
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
            body: '{"any_key":"any_value"}'),
      );
    });

    test('Should call post without body', () async {
      // action
      await sut.request(url: url, method: 'post');

      //assert
      verify(
        client.post(
          url,
          headers: anyNamed('headers'),
        ),
      );
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {"any_key": "any_value"});
    });

    test('Should return null if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');
      expect(response, null);
    });
  });
}
