import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forest_tinker_live/core/services/flagsmith.dart';
import 'package:forest_tinker_live/core/services/locator.dart';
import 'package:forest_tinker_live/features/onb/initial_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';
import 'package:forest_tinker_live/features/food_screen/model/recepi.dart';
import 'package:forest_tinker_live/features/home/model/food_model.dart';
import 'package:forest_tinker_live/features/home/model/water_model.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(FoodModelAdapter());
  Hive.registerAdapter(FoodTypeAdapter());
  Hive.registerAdapter(WaterModelAdapter());
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(IngredientAdapter());

  await LocatorOfServices.setServices();
  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: const MyApp(),
    ),
  );

  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(onDetach: GetIt.instance<Flagsmith>().closeClient),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Forest Tinker live',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: AppColors.surface,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
        home: const InitialScreen());
  }
}
