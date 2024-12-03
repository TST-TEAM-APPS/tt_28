import 'package:forest_tinker_live/features/home/model/food_model.dart';

class FoodViewModelState {
  double totalCalories;
  double totalProteins;
  double totalFats;
  double totalCarbs;
  double breakfastCalories;
  double lunchCalories;
  double dinnerCalories;
  double snackCalories;
  double totalBreakfastProteins;
  double totalDinnerProteins;
  double totalLunchProteins;
  double totalSnackProteins;
  double totalBreakfastFats;
  double totalDinnerFats;
  double totalLunchFats;
  double totalSnackFats;
  double totalBreakfastCarbs;
  double totalDinnerCarbs;
  double totalLunchCarbs;
  double totalSnackCarbs;
  int totalGlass;
  DateTime currentDateTime = DateTime.now();
  List<FoodModel?> dishesList;
  FoodModel? currentDish;
  FoodViewModelState({
    this.totalCalories = 0,
    this.totalCarbs = 0,
    this.totalFats = 0,
    this.totalProteins = 0,
    this.breakfastCalories = 0,
    this.snackCalories = 0,
    this.lunchCalories = 0,
    this.dinnerCalories = 0,
    required this.currentDateTime,
    this.currentDish,
    this.totalBreakfastProteins = 0,
    this.totalBreakfastCarbs = 0,
    this.totalBreakfastFats = 0,
    this.totalLunchProteins = 0,
    this.totalLunchFats = 0,
    this.totalLunchCarbs = 0,
    this.totalGlass = 0,
    this.totalDinnerProteins = 0,
    this.totalDinnerFats = 0,
    this.totalDinnerCarbs = 0,
    this.totalSnackProteins = 0,
    this.totalSnackFats = 0,
    this.totalSnackCarbs = 0,
    this.dishesList = const [],
  });
}
