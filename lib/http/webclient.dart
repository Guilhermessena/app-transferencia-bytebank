import 'package:http/http.dart';

import 'interceptors/logging_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = 'http://10.0.60.122:8080/transactions';