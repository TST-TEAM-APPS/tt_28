import 'package:flutter/material.dart';

import 'package:forest_tinker_live/features/statistics/service/statistic_food_service.dart';
import 'package:forest_tinker_live/features/statistics/service/statistic_water_service.dart';
import 'package:forest_tinker_live/features/statistics/view_model/statistic_state.dart';

class StatisticViewModel extends ChangeNotifier {
  final StatisticFoodService _foodService = StatisticFoodService();
  final StatisticWaterService _waterService = StatisticWaterService();
  StatisticState _state = StatisticState(currentDate: DateTime.now());
  StatisticState get state => _state;

  void loadData() async {
    await _foodService.loadData();
    await _waterService.loadData();
    _state = StatisticState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      currentDate: _foodService.currentDateTime!,
      foodList: _foodService.foodListWeek,
      waterList: _waterService.totalGlass,
    );

    notifyListeners();
  }

  StatisticViewModel() {
    loadData();
  }

  void onUpdatedDate(DateTime date) async {
    await _foodService.updateDate(date);
    await _waterService.updateDate(date);
    _state = StatisticState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      currentDate: _foodService.currentDateTime!,
      foodList: _foodService.foodListWeek,
      waterList: _waterService.totalGlass,
    );

    notifyListeners();
  }
}
