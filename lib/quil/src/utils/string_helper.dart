import 'package:flutter/cupertino.dart';

Map<String, String> parseKeyValuePairs(String s, Set<String> targetKeys) {
  final result = <String, String>{};
  final pairs = s.split(';');
  for (final pair in pairs) {
    final _index = pair.indexOf(':');
    if (_index < 0) {
      continue;
    }
    final _key = pair.substring(0, _index).trim();
    if (targetKeys.contains(_key)) {
      result[_key] = pair.substring(_index + 1).trim();
    }
  }

  return result;
}

Alignment getAlignment(String? s) {
  const _defaultAlignment = Alignment.center;
  if (s == null) {
    return _defaultAlignment;
  }

  final _index = [
    'topLeft',
    'topCenter',
    'topRight',
    'centerLeft',
    'center',
    'centerRight',
    'bottomLeft',
    'bottomCenter',
    'bottomRight'
  ].indexOf(s);
  if (_index < 0) {
    return _defaultAlignment;
  }

  return [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight
  ][_index];
}
