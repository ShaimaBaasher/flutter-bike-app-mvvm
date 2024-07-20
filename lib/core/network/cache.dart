import 'dart:convert';
import 'package:http/http.dart' as http;

class Cache {
  final Map<String, CachedResponse> _cache = {};

  Future<CachedResponse?> get(String key) async {
    if (_cache.containsKey(key) && !_cache[key]!.isExpired()) {
      return _cache[key];
    }
    return null;
  }

  Future<void> set(String key, http.Response response) async {
    _cache[key] = CachedResponse(response);
  }
}

class CachedResponse {
  final http.Response response;
  final DateTime timestamp;

  CachedResponse(this.response) : timestamp = DateTime.now();

  bool isExpired() {
    // Set cache expiration time (e.g., 1 hour)
    return DateTime.now().difference(timestamp).inMinutes > 60;
  }
}
