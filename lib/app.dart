import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/today/today_screen.dart';
import 'state/theme_provider.dart';
import 'state/mode_provider.dart';
import 'core/constants/app_modes.dart';

class DaylyApp extends ConsumerWidget {
  const DaylyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final mode = ref.watch(modeProvider);
    final config = modeConfigs[mode]!;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dayly',
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: config.accent),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: config.accent,
          brightness: Brightness.dark,
        ),
      ),
      home: const TodayScreen(),
    );
  }
}
