import 'package:http_interceptor/http_interceptor.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class LoggingInterceptor implements InterceptorContract {

  LoggingInterceptor();

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    log('----- Request -----');
    log('URL: ${request.url}');
    log('Method: ${request.method}');
    log('Headers: ${request.headers}');
    if (request is http.Request) {
      log('Body: ${request.body}');
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    log('----- Response -----');
    if (response.request != null) {
      log('URL: ${response.request!.url}');
    }
    log('Headers: ${response.headers}');
    log('Code: ${response.statusCode}');
    if (response is Response) {
      log((response).body);
    }
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async => true;
  @override
  Future<bool> shouldInterceptResponse() async => true;

}
