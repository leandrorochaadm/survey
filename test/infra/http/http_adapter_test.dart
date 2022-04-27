import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ClienteSpy extends Mock implements Client {}

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    client.post(url, headers: headers, body: jsonEncode(body));
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
    test('Shoudl call post with correct values', () async {
      // arrange

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
  });
}
