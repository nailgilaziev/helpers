library helpers;

import 'package:flutter/cupertino.dart';


extension Tracer on StackTrace {
  static List<String> myPackages = [
    'package:xclient',
    'package:conn_core',
    'package:conn_views',
    'package:app_logs',
    'package:common_widgets',
    'package:time_utils',
  ];

  String get shortExplanation =>
      ' ➤\n' +
          toString().split('\n').where((line) {
            return myPackages.any((package) => line.contains(package));
          }).map((line) {
            final op = line.lastIndexOf('(');
            return line.substring(op + 1, line.length - 1);
          }).join('\n');
}

String eInfo(Object e, StackTrace stackTrace) {
  return e.toString() + (stackTrace?.shortExplanation ?? '');
}

extension HandyCollection<E> on Iterable<E> {
  Iterable<T> mapNotNull<T>(T f(E t)) {
    return where((e) => e != null).map(f);
  }
}

void fd() {
  [1, 2].map((e) => e + 1);
  [1, 2].mapNotNull((e) => e + 1);
}


extension Injector on Iterable<Widget> {
  List<Widget> injectBetween(Widget inject) {
    final List<Widget> list = <Widget>[];
    final i = iterator;
    while (i.moveNext()) {
      list.add(i.current);
      list.add(inject);
    }
    list.removeLast();
    return list;
  }
}

extension SpaceInjector on Iterable<Widget> {
  List<Widget> injectVSpace(double v) {
    return injectBetween(SizedBox(height: v));
  }

  List<Widget> injectHSpace(double v) {
    return injectBetween(SizedBox(width: v));
  }

  List<Widget> injectSpace(double v) {
    return injectBetween(SizedBox(width: v, height: v));
  }
}

extension IterableToMap<E> on Iterable<E>{
  Map<K, V> toMapBy<K, V>({K mapKeys(E element), V mapValues(E element)}) {
    final m = <K, V>{};
    forEach((element) {
      m[mapKeys(element)] = mapValues == null ? element as V : mapValues(element);
    });
    return m;
  }
}

