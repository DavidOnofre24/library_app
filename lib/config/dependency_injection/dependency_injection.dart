import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  await getIt.reset();
}
