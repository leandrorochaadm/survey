import 'package:http/http.dart';

import '../../../data/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request({String url, String method, Map body}) {
    // TODO: implement request
    throw UnimplementedError();
  }
}
