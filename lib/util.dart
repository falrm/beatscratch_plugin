import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

extension ContextUtils on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.width > 500 && MediaQuery.of(this).size.height > 500;

  bool get isPhone => !isTablet;

  bool get isTabletOrLandscapey => MediaQuery.of(this).size.width > 500;

  bool get isLandscape => MediaQuery.of(this).size.width > MediaQuery.of(this).size.height;

  bool get isPortrait => !isLandscape;

  bool get isLandscapePhone => isLandscape && isPhone;

  bool get isPortraitPhone => isPortrait && isPhone;
}
extension Capitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
class MethodCache<KeyType, ResultType> {
  bool enable = true;
  Map<KeyType, ResultType> _data = Map();

  ResultType putIfAbsent(KeyType key, ResultType Function() computation) {
    if (!enable) {
      return computation();
    }
    return _data.putIfAbsent(key, () => computation());
  }

  clear() {
    _data.clear();
  }
}

/// Wrapper around [List<dynamic>] that calculates == and hashCode.
class ArgumentList {
  final List<dynamic> arguments;

  ArgumentList(this.arguments);

  @override
  bool operator ==(other) =>
      other is ArgumentList &&
      arguments.length == other.arguments.length &&
      !arguments.asMap().entries.any((entry) => other.arguments[entry.key] != entry.value);

  @override
  int get hashCode {
    int result;
    arguments.forEach((arg) {
      if (result == null) {
        result = arg.hashCode;
      } else {
        result = result ^ arg.hashCode;
      }
    });
    return result ?? 0;
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(<K, List<E>>{},
      (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));

  E maxBy(int Function(E) valueFunction) => (isEmpty)
      ? null
      : reduce((value, element) {
          if (value == null) {
            return element;
          }
          if (valueFunction(element) > valueFunction(value)) {
            return element;
          }
          return value;
        });

  E minBy(int Function(E) valueFunction) => reduce((value, element) {
        if (value == null) {
          return element;
        }
        if (valueFunction(element) < valueFunction(value)) {
          return element;
        }
        return value;
      });

  Iterable<Iterable<E>> chunked(int chunkSize) {
    return _chunkIterable(this, chunkSize);
  }
}

Iterable<Iterable<E>> _chunkIterable<E>(Iterable<E> iterable, int chunkSize) {
  if (iterable.isEmpty) {
    return [];
  }
  return [iterable.take(chunkSize)]..addAll(_chunkIterable(iterable.skip(chunkSize).toList(), chunkSize));
}

extension FancyIterable on Iterable<int> {
  int get maximum => reduce(max);

  int get minimum => reduce(min);
}
