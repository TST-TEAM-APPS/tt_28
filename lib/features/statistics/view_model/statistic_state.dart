import 'package:forest_tinker_live/features/statistics/service/statistic_water_service.dart';

class StatisticState {
  double totalCalories;
  double totalCarbs;
  double totalProteins;
  double totalFats;
  DateTime currentDate;
  List<DailyWaterData?> foodList;
  List<DailyWaterData> waterList;
  StatisticState({
    this.totalCalories = 0,
    this.totalCarbs = 0,
    this.totalProteins = 0,
    this.totalFats = 0,
    required this.currentDate,
    this.foodList = const [],
    this.waterList = const [],
  });
}
