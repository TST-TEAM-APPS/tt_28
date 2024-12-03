import 'package:forest_tinker_live/core/services/flagsmith.dart';
import 'package:forest_tinker_live/core/services/network_service.dart';
import 'package:get_it/get_it.dart';


class LocatorOfServices {
  static Future<void> setServices() async {
    GetIt.I.registerSingletonAsync<Flagsmith>(() => Flagsmith().init());
    await GetIt.I.isReady<Flagsmith>();
    GetIt.I.registerSingleton<NetworkService>(NetworkService());
  }
}
