import 'dart:convert';


import 'package:get_it/get_it.dart';
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

  // InterceptedClient client = InterceptedClient.build(
  //   interceptors: [LoggingInterceptor()],
  // );

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
        response = await clientHttp.put(Uri.parse(apiUrl),
            body: json.encode(params), headers: headers);
      } else {
        response = await clientHttp
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
    final clientHttp = GetIt.instance<http.Client>();
    final cache = GetIt.instance<Cache>();

    final uri = Uri.parse(apiUrl);
    final key = generateCacheKey(apiUrl, headers);

    // Check if we have a cached response
    final cachedResponse = await cache.get(key);
    if (cachedResponse != null) {
      // Return the cached response if it exists
      print("Returning cached response for key: $key");
      try {
        print('cachedResponse.body>>${cachedResponse.body}');
        return cachedResponse.body;
      } catch (e) {
        print("Error decoding cached response: $e");
        throw ApiException(message: "Error decoding cached response", statusCode: 500);
      }
    }

    Map<String, String> params = {
      'Authorization': 'Bearer ',
    };

    if (headers.isNotEmpty) {
      params.addAll(headers);
    }

    try {
      var response = await clientHttp.get(Uri.parse(apiUrl), headers: params);

      if (response.statusCode == 401) {
        throw ApiException(message: "Unauthorized access", statusCode: 401);
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(message: response.body, statusCode: response.statusCode);
      }

      // Cache the new response
      await cache.set(key, response);
      print("Caching new response for key: $key");
      try {
        return response.body;
      } catch (e) {
        print("Error decoding network response: $e");
        throw ApiException(message: "Error decoding network response", statusCode: 500);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      // If network error occurs, return cached data if available
      if (cachedResponse != null) {
        print("Network error, returning cached response for key: $key");
        try {
          return cachedResponse.body;
        } catch (e) {
          print("Error decoding cached response: $e");
          throw ApiException(message: "Error decoding cached response", statusCode: 500);
        }
      } else {
        throw ApiException(message: "Network error and no cached data available", statusCode: 505);
      }
    }
  }


  String generateCacheKey(String url, Map<String, String> headers) {
    final sortedHeaders = headers.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final headersString = sortedHeaders.map((entry) => '${entry.key}:${entry.value}').join('&');
    return '$url?$headersString';
  }


}
