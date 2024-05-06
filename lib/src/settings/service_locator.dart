import 'package:get_it/get_it.dart';

import 'settings_controller.dart';
import 'settings_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<SettingsService>(() => SettingsService());

  // Register controllers with dependencies
  locator.registerFactory(() => SettingsController(locator<SettingsService>()));
}
