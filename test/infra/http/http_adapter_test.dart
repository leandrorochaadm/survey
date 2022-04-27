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
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    client.post(url, headers: headers);
  }
}

void main() {
  group('post', () {
    test('Shoudl call post with correct values', () async {
      // arrange
      final client = ClienteSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      // action
      await sut.request(url: url, method: 'post');

      //assert
      verify(
        client.post(
          url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
          },
        ),
      );
    });
  });
}
