import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/mode_provider.dart';
import '../../core/constants/app_modes.dart';

class ModeSelector extends ConsumerWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(modeProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: AppMode.values.map((mode) {
          final config = modeConfigs[mode]!;
          final isActive = mode == current;

          return ListTile(
            leading: CircleAvatar(backgroundColor: config.accent),
            title: Text(mode.name.toUpperCase()),
            trailing:
                isActive ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () {
              ref.read(modeProvider.notifier).setMode(mode);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
