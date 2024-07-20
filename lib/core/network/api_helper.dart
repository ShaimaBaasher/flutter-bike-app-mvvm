import 'dart:convert';


import 'package:http_interceptor/http/intercepted_client.dart';

import 'cache.dart';
import 'errors/exceptions.dart';
import 'package:http/http.dart' as http;

import 'logging_interceptor.dart';

class APISRepo {
  final http.Client clientHttp;
  final Cache cache;
  final String apiUrl;

  APISRepo(this.clientHttp, this.cache, this.apiUrl);

  InterceptedClient client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  Future<dynamic> postRequest(
      {required String apiUrl,
      required Map<String, dynamic> params,
      List<Map<String, dynamic>>? paramsList,
      bool isAuthRequired = true,
      bool isPutMethod = false}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ',
      "Content-Type": "application/json",
      'Connection': 'keep-alive',
      "accept": "*/*",
    };

    try {
      http.Response response;

      if (isPutMethod) {
        response = await client.put(Uri.parse(apiUrl),
            body: json.encode(params), headers: headers);
      } else {
        response = await client
            .post(Uri.parse(apiUrl),
                body: json.encode(paramsList ?? params), headers: headers);
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
      return response.body;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  Future<dynamic> getRequest({
    required String apiUrl,
    required Map<String, String> headers,
    String? urlName,
  }) async {
    final uri = Uri.parse(apiUrl);
    final key = uri.toString() + headers.toString();

    // Check if we have a cached response
    final cachedResponse = await cache.get(key);
    if (cachedResponse != null) {
      // Return the cached response if it exists
      return json.decode(cachedResponse.response.body);
    }

    Map<String, String> params = {
      'Authorization': 'Bearer ',
    };

    if (headers.isNotEmpty) {
      params.addAll(headers);
    }

    try {
      var response = await client.get(Uri.parse(apiUrl), headers: params);

      if (response.statusCode == 401) {
        // Handle unauthorized access (e.g., refresh token, re-authenticate)
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }

      // Cache the new response
      await cache.set(key, response);
      return response.body;
    } on ApiException {
      rethrow;
    } catch (e) {
      // If network error occurs, return cached data if available
      if (cachedResponse != null) {
        return json.decode(cachedResponse.response.body);
      } else {
        throw ApiException(message: e.toString(), statusCode: 505);
      }
    }
  }

}
