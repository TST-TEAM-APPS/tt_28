import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/btm.dart';
import 'package:forest_tinker_live/core/colors.dart';

import 'package:forest_tinker_live/features/food_screen/view/food_screen.dart';
import 'package:forest_tinker_live/features/home/view/home_screen.dart';
import 'package:forest_tinker_live/features/home/view_model/food_view_model.dart';

import 'package:forest_tinker_live/features/statistics/view/statistics_screen.dart';
import 'package:forest_tinker_live/features/statistics/view_model/statistic_view_model.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _currentIndex = 0;

  final List<PageModel> _pages = [
    PageModel(
      page: ChangeNotifierProvider(
          create: (_) => FoodViewModel(), child: const HomeScreen()),
      iconPath: 'assets/icons/1.png',
    ),
    PageModel(
      page: ChangeNotifierProvider(
          create: (_) => StatisticViewModel(), child: const StatisticsScreen()),
      iconPath: 'assets/icons/2.png',
    ),
    PageModel(
      page: RecipesScreen(),
      iconPath: 'assets/icons/3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex].page,
      bottomNavigationBar: WoDownBar(
        onPageChanged: (index) {
          _currentIndex = index;
          setState(() {});
        },
        pages: _pages,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 52,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_pages[index].iconPath != null)
                  Image.asset(
                    _pages[index].iconPath!,
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.primaryFixed,
                    width: 24,
                  ),
                if (_pages[index].title != null)
                  const SizedBox(
                    height: 9,
                  ),
                if (_pages[index].title != null)
                  Text(
                    _pages[index].title!,
                    style: AppFonts.titleMedium.copyWith(
                      color: _currentIndex == index
                          ? AppColors.onPrimaryFixed
                          : AppColors.onPrimary,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 2,
                  width: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: _currentIndex == index
                        ? AppColors.primary
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
