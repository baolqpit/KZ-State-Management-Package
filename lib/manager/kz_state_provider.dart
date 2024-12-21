import 'package:flutter/cupertino.dart';

import 'kz_state_manager.dart';

class KzStateProvider<T> extends InheritedWidget {
  final KzStateManager<T> stateManager;

  const KzStateProvider(
      {super.key, required this.stateManager, required super.child});

  static KzStateProvider<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<KzStateProvider<T>>();
  }

  @override
  bool updateShouldNotify(KzStateProvider<T> oldWidget) {
    return oldWidget.stateManager != stateManager;
  }
}
