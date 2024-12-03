// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forest_tinker_live/core/services/mixins/network_mixin.dart';
import 'package:forest_tinker_live/features/onb/onb_screen.dart';
import 'package:forest_tinker_live/features/parent_screen/parent_screen.dart';
import 'package:forest_tinker_live/features/settings/ui/more_info_screen.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:is_first_run/is_first_run.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> with NetworkMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  Future<void> _init() async {
    await isUserConnected(
      onError: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const InitialScreen()),
      ),
    );

    final isFirstRun = await IsFirstRun.isFirstRun();

    if (isFirstRun) {
      InAppReview.instance.requestReview();
    }

    if (!canNavigate) {
      if (isFirstRun) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const Onb(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const ParentScreen(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const MoreInfoScreen(),
        ),
      );
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
