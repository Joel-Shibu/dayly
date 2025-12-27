import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const _boxName = 'themeBox';
  static const _key = 'theme';

  ThemeNotifier() : super(ThemeMode.system) {
    final box = Hive.box(_boxName);
    state = box.get(_key, defaultValue: ThemeMode.system);
  }

  void setTheme(ThemeMode mode) {
    state = mode;
    Hive.box(_boxName).put(_key, mode);
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
