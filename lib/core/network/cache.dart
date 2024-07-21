import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;


class Cache {
  static const String _boxName = 'cacheBox';

  Future<Box> _openBox() async {
    return await Hive.openBox(_boxName);
  }

  Future<CachedItem?> get(String key) async {
    final box = await _openBox();
    final item = box.get(key);
    if (item != null) {
      return CachedItem.fromMap(Map<String, dynamic>.from(item as Map));
    }
    return null;
  }

  Future<void> set(String key, http.Response response) async {
    final box = await _openBox();
    final cachedItem = CachedItem(response);
    await box.put(key, cachedItem.toMap());
  }
}

class CachedItem {
  final String body;
  final int statusCode;
  final Map<String, String> headers;
  final DateTime timestamp;

  CachedItem(http.Response response)
      : body = response.body,
        statusCode = response.statusCode,
        headers = response.headers,
        timestamp = DateTime.now();

  CachedItem.fromMap(Map<String, dynamic> map)
      : body = map['body'] as String,
        statusCode = map['statusCode'] as int,
        headers = Map<String, String>.from(map['headers'] as Map),
        timestamp = DateTime.parse(map['timestamp'] as String);

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'statusCode': statusCode,
      'headers': headers,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

