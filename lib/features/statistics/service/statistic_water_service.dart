import 'package:hive/hive.dart';

import 'package:tt_28/features/home/model/water_model.dart';

class DailyWaterData {
  final DateTime date;
  final int totalWater;

  DailyWaterData({required this.date, required this.totalWater});
}

class StatisticWaterService {
  List<WaterModel?> _waterList = [];
  DateTime _currentDate = DateTime.now();
  List<DailyWaterData> _totalGlass = [];

  List<DailyWaterData> get totalGlass => _totalGlass;

  Future<void> loadData() async {
    final foodModelBox = await Hive.openBox<WaterModel>('_waterList');
    _waterList = foodModelBox.values.toList();
    await update();
  }

  Future<void> update() async {
    _totalGlass = await getWaterListForWeek(_currentDate);
  }

  Future<void> updateDate(DateTime date) async {
    _currentDate = date;
    await update();
  }

  Future<List<DailyWaterData>> getWaterListForWeek(DateTime date) async {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final List<DailyWaterData> dailyTotals = [];

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));

      final filteredModelList = _waterList.where((value) {
        final createdDate = value?.createdDate;
        if (createdDate == null) return false;

        return DateTime(createdDate.year, createdDate.month, createdDate.day)
            .isAtSameMomentAs(DateTime(day.year, day.month, day.day));
      }).toList();

      final totalWater = filteredModelList.fold<int>(
        0,
        (sum, item) => sum + (item?.quantity ?? 0),
      );

      dailyTotals.add(DailyWaterData(date: day, totalWater: totalWater));
    }

    return dailyTotals;
  }

  Future<void> setFood(WaterModel foodModel) async {
    final foodModelBox = await Hive.openBox<WaterModel>('_waterList');
    await foodModelBox.add(foodModel);

    await loadData();
  }

  Future<void> deleteFoodForWeek() async {
    final foodModelBox = await Hive.openBox<WaterModel>('_waterList');
    final startOfWeek =
        _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final keysToDelete = foodModelBox.keys.where((key) {
      final value = foodModelBox.get(key);
      if (value == null) return false;
      final createdDate = value.createdDate;
      return createdDate
              .isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
          createdDate.isBefore(endOfWeek.add(const Duration(seconds: 1)));
    }).toList();

    for (final key in keysToDelete) {
      await foodModelBox.delete(key);
    }

    await loadData();
  }
}
