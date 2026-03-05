import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/provider/app_state_notifier.dart';
import 'package:flutter_snackautomat/provider/app_state.dart';

/// Provider for the app state using Riverpod.
/// This provider manages all the state for the vending machine app.
final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(
  () => AppStateNotifier(),
);
