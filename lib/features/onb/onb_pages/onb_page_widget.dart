import 'package:flutter/material.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';

class OnbPageWidget extends StatelessWidget {
  final String image;
  final String title;

  const OnbPageWidget({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            child: Image.asset(
              image,
              height: 242,
              width: 242,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 77,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.headlineMedium.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
