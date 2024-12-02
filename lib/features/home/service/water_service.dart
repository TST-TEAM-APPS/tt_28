import 'package:hive/hive.dart';
import 'package:tt_28/features/home/model/water_model.dart';

class WaterService {
  List<WaterModel?> _waterList = [];
  DateTime _currentDate = DateTime.now();
  int _totalGlass = 0;

  int get totalGlass => _totalGlass;

  Future<void> loadData() async {
    final foodModelBox = await Hive.openBox<WaterModel>('_waterList');
    _waterList = foodModelBox.values.toList();
    await update();
  }

  Future<void> update() async {
    _totalGlass = await getWaterList(_currentDate);
  }

  Future<void> updateDate(DateTime date) async {
    _currentDate = date;
    await update();
  }

  Future<int> getWaterList(DateTime date) async {
    final foodModelList = _waterList;
    if (foodModelList.isEmpty) {
      return 0;
    }

    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.createdDate.day, value.createdDate.month,
              value.createdDate.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (filteredModelList.isNotEmpty) {
      filteredModelList.fold<int>(0, (sum, item) => sum + item!.quantity);

      return filteredModelList.fold<int>(
          0, (sum, item) => sum + item!.quantity);
    } else {
      _totalGlass = 0;
    }
    return 0;
  }

  Future<void> setFood(WaterModel foodModel) async {
    final foodModelBox = await Hive.openBox<WaterModel>('_waterList');
    await foodModelBox.add(foodModel);

    await loadData();
  }

  Future<void> deleteFood() async {
    final foodModelBox = await Hive.openBox<WaterModel>('_waterList');
    // final foodModelList = foodModelBox.values.toList();
    // final filteredModelList = foodModelList.where((value) {
    //   return DateTime(value.createdDate.day, value.createdDate.month,
    //           value.createdDate.year)
    //       .isAtSameMomentAs(DateTime(
    //           _currentDate.day, _currentDate.month, _currentDate.year));
    // }).toList();
    // if (filteredModelList.isNotEmpty) {
    //   final indexToDelete = foodModelList.indexOf(filteredModelList.first);
    //   await foodModelBox.deleteAt(indexToDelete);
    //   await update();
    // }

    final keyToDelete = foodModelBox.keys.firstWhere(
      (key) {
        final value = foodModelBox.get(key);
        if (value == null) return false;
        final createdDate = value.createdDate;
        return DateTime(createdDate.year, createdDate.month, createdDate.day)
            .isAtSameMomentAs(DateTime(
                _currentDate.year, _currentDate.month, _currentDate.day));
      },
      orElse: () => null,
    );
    if (keyToDelete != null) {
      await foodModelBox.delete(keyToDelete);
      await update();
    } else {
      print('Запись для удаления не найдена');
    }
    await loadData();
  }
}
