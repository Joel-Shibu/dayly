import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../core/constants/app_modes.dart';

class ModeNotifier extends StateNotifier<AppMode> {
  static const _boxName = 'modeBox';
  static const _key = 'currentMode';

  ModeNotifier() : super(_loadInitial());

  static AppMode _loadInitial() {
    try {
      final box = Hive.box<String>(_boxName);
      final modeString = box.get(_key, defaultValue: AppMode.work.name);
      return AppMode.values.firstWhere(
        (mode) => mode.name == modeString,
        orElse: () => AppMode.work,
      );
    } catch (e) {
      return AppMode.work;
    }
  }

  void setMode(AppMode mode) {
    state = mode;
    try {
      final box = Hive.box<String>(_boxName);
      box.put(_key, mode.name);
      box.flush();
    } catch (e) {
      // Ignore errors during mode setting
    }
  }
}

final modeProvider =
    StateNotifierProvider<ModeNotifier, AppMode>((ref) {
  return ModeNotifier();
});
