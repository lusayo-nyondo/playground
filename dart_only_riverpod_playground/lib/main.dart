import 'package:riverpod/riverpod.dart';

final helloWorldProvider = Provider(
  (_) => 'Hello World form riverpod provider.',
);

final stateProvider = StateProvider((_) => 0);

run() {
  final container = ProviderContainer();

  print(container.read(helloWorldProvider).runtimeType);
  print(container.read(stateProvider).runtimeType);
}
