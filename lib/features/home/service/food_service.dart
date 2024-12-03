import 'package:hive/hive.dart';
import 'package:forest_tinker_live/features/home/model/food_model.dart';

class FoodService {
  List<FoodModel?> _foodList = [];
  List<FoodModel?>? _foodBreakfestList;
  List<FoodModel?>? _foodLunchList;
  List<FoodModel?>? _foodDinnerList;
  List<FoodModel?>? _foodSnakList;
  double _totalCalories = 0;
  double _totalProteins = 0;
  double _totalCarbs = 0;
  double _totalFats = 0;

  double _totalBreakfast = 0;
  double _totalLunch = 0;
  double _totalDinner = 0;
  double _totalSnack = 0;

  double _totalBreakfastProteins = 0;
  double _totalDinnerProteins = 0;
  double _totalLunchProteins = 0;
  double _totalSnackProteins = 0;

  double _totalBreakfastFats = 0;
  double _totalDinnerFats = 0;
  double _totalLunchFats = 0;
  double _totalSnackFats = 0;

  double _totalBreakfastCarbs = 0;
  double _totalDinnerCarbs = 0;
  double _totalLunchCarbs = 0;
  double _totalSnackCarbs = 0;

  DateTime _dateTime = DateTime.now();

  double get totalBreakfastProteins => _totalBreakfastProteins;
  double get totalDinnerProteins => _totalDinnerProteins;
  double get totalLunchProteins => _totalLunchProteins;
  double get totalSnackProteins => _totalSnackProteins;

  double get totalBreakfastFats => _totalBreakfastFats;
  double get totalDinnerFats => _totalDinnerFats;
  double get totalLunchFats => _totalLunchFats;
  double get totalSnackFats => _totalSnackFats;

  double get totalBreakfastCarbs => _totalBreakfastCarbs;
  double get totalDinnerCarbs => _totalDinnerCarbs;
  double get totalLunchCarbs => _totalLunchCarbs;
  double get totalSnackCarbs => _totalSnackCarbs;

  List<FoodModel?>? get foodBreakfestList => _foodBreakfestList;
  List<FoodModel?>? get foodLunchList => _foodLunchList;
  List<FoodModel?>? get foodDinnerList => _foodDinnerList;
  List<FoodModel?>? get foodSnakList => _foodSnakList;
  double get totalBreakfast => _totalBreakfast;
  double get totalLunch => _totalLunch;
  double get totalDinner => _totalDinner;
  double get totalSnack => _totalSnack;

  double get totalCalories => _totalCalories;
  double get totalProteins => _totalProteins;
  double get totalCarbs => _totalCarbs;
  double get totalFats => _totalFats;
  DateTime? get currentDateTime => _dateTime;

  Future<void> loadData() async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');
    _foodList = foodModelBox.values.toList();
    await update();
  }

  Future<void> update() async {
    _foodBreakfestList = await getBreakfestList(_dateTime);
    _foodLunchList = await getLunchList(_dateTime);
    _foodDinnerList = await getDinnerList(_dateTime);
    _foodSnakList = await getSnackList(_dateTime);
    _totalCalories = await getTotalCalories(_dateTime);
    _totalCarbs = await getTotalCarbs(_dateTime);
    _totalFats = await getTotalFats(_dateTime);

    _totalProteins = await getTotalProteins(_dateTime);
  }

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;
    await update();
  }

  Future<void> setFood(FoodModel foodModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');
    await foodModelBox.add(foodModel);
    _foodList.add(foodModel);
    await update();
  }

  Future<void> deleteFood(FoodModel foodModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');
    final foodModelList = foodModelBox.values.toList();
    if (foodModelList.contains(foodModel)) {
      _foodList.remove(foodModel);
      await foodModelBox.delete(foodModel);
    }
    await update();
  }

  Future<List<FoodModel?>?> getBreakfestList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }

    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.breakfast;
    }).toList();
    if (filteredModelList.isNotEmpty) {
      _totalBreakfast = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.calories);
      _totalBreakfastProteins = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.proteins);
      _totalBreakfastFats =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.fats);
      _totalBreakfastCarbs =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
      filteredModelList.sort((a, b) => b!.date.compareTo(a!.date));
      return filteredModelList;
    } else {
      _totalBreakfast = 0;
      _totalBreakfastProteins = 0;
      _totalBreakfastFats = 0;
      _totalBreakfastCarbs = 0;

      _totalBreakfastProteins = 0;

      _totalBreakfastFats = 0;

      _totalBreakfastCarbs = 0;
    }
    return null;
  }

  Future<List<FoodModel?>?> getLunchList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }
    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.lunch;
    }).toList();

    if (filteredModelList.isNotEmpty) {
      _totalLunch = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.calories);
      _totalLunchProteins = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.proteins);
      _totalLunchFats =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.fats);
      _totalLunchCarbs =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
      return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
    } else {
      _totalLunch = 0;
      _totalLunchProteins = 0;
      _totalLunchFats = 0;
      _totalLunchCarbs = 0;

      _totalLunchProteins = 0;

      _totalLunchFats = 0;

      _totalLunchCarbs = 0;
    }
    return null;
  }

  Future<double> getTotalCalories(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.calories);
  }

  Future<double> getTotalCarbs(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
  }

  Future<double> getTotalProteins(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.proteins);
  }

  Future<double> getTotalFats(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.fats);
  }

  Future<List<FoodModel?>?> getDinnerList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }

    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.dinner;
    }).toList();
    if (filteredModelList.isNotEmpty) {
      _totalDinner = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.calories);
      _totalDinnerProteins = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.proteins);
      _totalDinnerFats =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.fats);
      _totalDinnerCarbs =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
      return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
    } else {
      _totalDinner = 0;
      _totalDinnerProteins = 0;
      _totalDinnerFats = 0;
      _totalDinnerCarbs = 0;

      _totalDinnerProteins = 0;

      _totalDinnerFats = 0;

      _totalDinnerCarbs = 0;
    }
    return null;
  }

  Future<List<FoodModel?>?> getSnackList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }

    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.snack;
    }).toList();
    if (filteredModelList.isNotEmpty) {
      _totalSnack = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.calories);
      _totalSnackProteins = filteredModelList.fold<double>(
          0, (sum, item) => sum + item!.proteins);
      _totalSnackFats =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.fats);
      _totalSnackCarbs =
          filteredModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
      return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
    } else {
      _totalSnack = 0;
      _totalSnackProteins = 0;
      _totalSnackFats = 0;
      _totalSnackCarbs = 0;
      _totalSnackProteins = 0;
      _totalSnackFats = 0;
      _totalSnackCarbs = 0;
    }

    return null;
  }
}
