import 'package:forest_tinker_live/core/services/flagsmith.dart';
import 'package:get_it/get_it.dart';


mixin MainConfig {
  final _flagsmith = GetIt.instance<Flagsmith>();

  String get privacy => _flagsmith.config.privacyLink;

  String get terms => _flagsmith.config.termsLink;
}
