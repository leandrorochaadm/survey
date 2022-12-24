import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../main/factories/http/http.dart';

Authentication makeRemoteAuthentication() {
  final url = makeApiUrl('login');
  final httpAdapter = makeHttpAdapter();

  return RemoteAuthentication(httpClient: httpAdapter, url: url);
}
