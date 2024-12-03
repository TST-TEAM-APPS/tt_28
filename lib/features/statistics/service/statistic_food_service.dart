import 'package:hive/hive.dart';
import 'package:forest_tinker_live/features/home/model/food_model.dart';
import 'package:forest_tinker_live/features/statistics/service/statistic_water_service.dart';

class StatisticFoodService {
  List<FoodModel?> _foodList = [];
  double _totalCalories = 0;
  double _totalProteins = 0;
  double _totalCarbs = 0;
  double _totalFats = 0;

  List<DailyWaterData?> _foodListWeek = [];

  DateTime _dateTime = DateTime.now();

  double get totalCalories => _totalCalories;
  double get totalProteins => _totalProteins;
  double get totalCarbs => _totalCarbs;
  double get totalFats => _totalFats;
  DateTime? get currentDateTime => _dateTime;
  List<DailyWaterData?> get foodListWeek => _foodListWeek;

  Future<void> loadData() async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');

    _foodList = foodModelBox.values.toList();
    await update();
  }

  DateTime get startOfWeek {
    return currentDateTime!
        .subtract(Duration(days: currentDateTime!.weekday - 1));
  }

  DateTime get endOfWeek {
    return startOfWeek.add(const Duration(days: 6));
  }

  Future<void> update() async {
    _totalCalories = await getTotalCaloriesForWeek(_dateTime);
    _totalCarbs = await getTotalCarbsForWeek(_dateTime);
    _totalFats = await getTotalProteinsForWeek(_dateTime);
    _totalProteins = await getTotalFatsForWeek(_dateTime);
    _foodListWeek = await getWaterListForWeek(_dateTime);
    // _foodListWeek = _foodList.where((e) {
    //   final date = e!.date;
    //   return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
    //       date.isBefore(endOfWeek.add(const Duration(seconds: 1)));
    // }).toList();
  }

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;
    await update();
  }

  Future<List<DailyWaterData>> getWaterListForWeek(DateTime date) async {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final List<DailyWaterData> dailyTotals = [];

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));

      final filteredModelList = _foodList.where((value) {
        final createdDate = value?.date;
        if (createdDate == null) return false;

        return DateTime(createdDate.year, createdDate.month, createdDate.day)
            .isAtSameMomentAs(DateTime(day.year, day.month, day.day));
      }).toList();

      final totalWater = filteredModelList.fold<int>(
        0,
        (sum, item) => sum + (item?.calories ?? 0).toInt(),
      );

      dailyTotals.add(DailyWaterData(date: day, totalWater: totalWater));
    }

    return dailyTotals;
  }

  Future<double> getTotalCaloriesForWeek(DateTime currentDate) async {
    final startOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final foodModelList = _foodList.where((value) {
      final date = value!.date;
      return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
          date.isBefore(endOfWeek.add(const Duration(seconds: 1)));
    }).toList();

    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.calories);
  }

  Future<double> getTotalCarbsForWeek(DateTime currentDate) async {
    final startOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final foodModelList = _foodList.where((value) {
      final date = value!.date;
      return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
          date.isBefore(endOfWeek.add(const Duration(seconds: 1)));
    }).toList();

    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
  }

  Future<double> getTotalProteinsForWeek(DateTime currentDate) async {
    final startOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final foodModelList = _foodList.where((value) {
      final date = value!.date;
      return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
          date.isBefore(endOfWeek.add(const Duration(seconds: 1)));
    }).toList();

    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.proteins);
  }

  Future<double> getTotalFatsForWeek(DateTime currentDate) async {
    final startOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final foodModelList = _foodList.where((value) {
      final date = value!.date;
      return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
          date.isBefore(endOfWeek.add(const Duration(seconds: 1)));
    }).toList();

    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.fats);
  }
}
