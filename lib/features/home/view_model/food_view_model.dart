import 'package:flutter/material.dart';
import 'package:tt_28/features/home/model/food_model.dart';
import 'package:tt_28/features/home/model/water_model.dart';
import 'package:tt_28/features/home/service/dish_service.dart';
import 'package:tt_28/features/home/service/food_service.dart';
import 'package:tt_28/features/home/service/water_service.dart';
import 'package:tt_28/features/home/view_model/food_state.dart';

class FoodViewModel extends ChangeNotifier {
  final FoodService _foodService = FoodService();
  final WaterService _waterService = WaterService();
  FoodViewModelState _state =
      FoodViewModelState(currentDateTime: DateTime.now());
  final DishService _dishService = DishService();
  FoodViewModelState get state => _state;

  void loadData() async {
    await _foodService.loadData();
    await _dishService.loadData();
    await _waterService.loadData();
    _state = FoodViewModelState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      currentDateTime: _foodService.currentDateTime!,
      currentDish: _dishService.currentDish,
      totalGlass: _waterService.totalGlass,
      dishesList: _dishService.dishList,
      breakfastCalories: _foodService.totalBreakfast,
      lunchCalories: _foodService.totalLunch,
      dinnerCalories: _foodService.totalDinner,
      snackCalories: _foodService.totalSnack,
      totalBreakfastProteins: _foodService.totalBreakfastProteins,
      totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
      totalBreakfastFats: _foodService.totalBreakfastCarbs,
      totalDinnerProteins: _foodService.totalDinnerProteins,
      totalDinnerCarbs: _foodService.totalDinnerCarbs,
      totalDinnerFats: _foodService.totalDinnerFats,
      totalLunchCarbs: _foodService.totalLunchCarbs,
      totalLunchProteins: _foodService.totalLunchProteins,
      totalLunchFats: _foodService.totalLunchFats,
      totalSnackCarbs: _foodService.totalSnackCarbs,
      totalSnackFats: _foodService.totalSnackFats,
      totalSnackProteins: _foodService.totalSnackProteins,
    );

    notifyListeners();
  }

  FoodViewModel() {
    loadData();
  }

  void onDeleteFood(FoodModel foodModel) async {
    await _foodService.deleteFood(foodModel);
    _state = FoodViewModelState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      currentDateTime: _foodService.currentDateTime!,
      totalGlass: _waterService.totalGlass,
      currentDish: _dishService.currentDish,
      dishesList: _dishService.dishList,
      breakfastCalories: _foodService.totalBreakfast,
      lunchCalories: _foodService.totalLunch,
      dinnerCalories: _foodService.totalDinner,
      snackCalories: _foodService.totalSnack,
      totalBreakfastProteins: _foodService.totalBreakfastProteins,
      totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
      totalBreakfastFats: _foodService.totalBreakfastCarbs,
      totalDinnerProteins: _foodService.totalDinnerProteins,
      totalDinnerCarbs: _foodService.totalDinnerCarbs,
      totalDinnerFats: _foodService.totalDinnerFats,
      totalLunchCarbs: _foodService.totalLunchCarbs,
      totalLunchProteins: _foodService.totalLunchProteins,
      totalLunchFats: _foodService.totalLunchFats,
      totalSnackCarbs: _foodService.totalSnackCarbs,
      totalSnackFats: _foodService.totalSnackFats,
      totalSnackProteins: _foodService.totalSnackProteins,
    );
    notifyListeners();
  }

  void onChangeTab(bool tab) async {
    await _dishService.changeTab(tab);
    _state = FoodViewModelState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      currentDateTime: _foodService.currentDateTime!,
      currentDish: _dishService.currentDish,
      dishesList: _dishService.dishList,
      breakfastCalories: _foodService.totalBreakfast,
      totalGlass: _waterService.totalGlass,
      lunchCalories: _foodService.totalLunch,
      dinnerCalories: _foodService.totalDinner,
      snackCalories: _foodService.totalSnack,
      totalBreakfastProteins: _foodService.totalBreakfastProteins,
      totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
      totalBreakfastFats: _foodService.totalBreakfastCarbs,
      totalDinnerProteins: _foodService.totalDinnerProteins,
      totalDinnerCarbs: _foodService.totalDinnerCarbs,
      totalDinnerFats: _foodService.totalDinnerFats,
      totalLunchCarbs: _foodService.totalLunchCarbs,
      totalLunchProteins: _foodService.totalLunchProteins,
      totalLunchFats: _foodService.totalLunchFats,
      totalSnackCarbs: _foodService.totalSnackCarbs,
      totalSnackFats: _foodService.totalSnackFats,
      totalSnackProteins: _foodService.totalSnackProteins,
    );
    notifyListeners();
  }

  Future<void> onDishItemAdded(FoodModel foodModel) async {
    _dishService.setFood(foodModel).then((_) {
      _state = FoodViewModelState(
        totalCalories: _foodService.totalCalories,
        totalCarbs: _foodService.totalCarbs,
        totalFats: _foodService.totalFats,
        totalProteins: _foodService.totalProteins,
        currentDateTime: _foodService.currentDateTime!,
        currentDish: _dishService.currentDish,
        dishesList: _dishService.dishList,
        breakfastCalories: _foodService.totalBreakfast,
        lunchCalories: _foodService.totalLunch,
        dinnerCalories: _foodService.totalDinner,
        totalGlass: _waterService.totalGlass,
        snackCalories: _foodService.totalSnack,
        totalBreakfastProteins: _foodService.totalBreakfastProteins,
        totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
        totalBreakfastFats: _foodService.totalBreakfastCarbs,
        totalDinnerProteins: _foodService.totalDinnerProteins,
        totalDinnerCarbs: _foodService.totalDinnerCarbs,
        totalDinnerFats: _foodService.totalDinnerFats,
        totalLunchCarbs: _foodService.totalLunchCarbs,
        totalLunchProteins: _foodService.totalLunchProteins,
        totalLunchFats: _foodService.totalLunchFats,
        totalSnackCarbs: _foodService.totalSnackCarbs,
        totalSnackFats: _foodService.totalSnackFats,
        totalSnackProteins: _foodService.totalSnackProteins,
      );
      notifyListeners();
    });
  }

  Future<void> getDishById(int id) async {
    _dishService.getDishById(id);
  }

  Future<void> onUpdatedFood(FoodModel foodModel) async {
    _dishService.editFood(foodModel).then((_) {
      _state = FoodViewModelState(
        totalCalories: _foodService.totalCalories,
        totalCarbs: _foodService.totalCarbs,
        totalFats: _foodService.totalFats,
        totalProteins: _foodService.totalProteins,
        currentDateTime: _foodService.currentDateTime!,
        dishesList: _dishService.dishList,
        breakfastCalories: _foodService.totalBreakfast,
        lunchCalories: _foodService.totalLunch,
        totalGlass: _waterService.totalGlass,
        dinnerCalories: _foodService.totalDinner,
        snackCalories: _foodService.totalSnack,
        totalBreakfastProteins: _foodService.totalBreakfastProteins,
        totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
        totalBreakfastFats: _foodService.totalBreakfastCarbs,
        totalDinnerProteins: _foodService.totalDinnerProteins,
        totalDinnerCarbs: _foodService.totalDinnerCarbs,
        totalDinnerFats: _foodService.totalDinnerFats,
        totalLunchCarbs: _foodService.totalLunchCarbs,
        totalLunchProteins: _foodService.totalLunchProteins,
        totalLunchFats: _foodService.totalLunchFats,
        totalSnackCarbs: _foodService.totalSnackCarbs,
        totalSnackFats: _foodService.totalSnackFats,
        totalSnackProteins: _foodService.totalSnackProteins,
      );
      notifyListeners();
    });
  }

  void onUpdatedDate(DateTime date) async {
    await _foodService.updateDate(date);
    await _waterService.updateDate(date);
    _state = FoodViewModelState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      currentDateTime: _foodService.currentDateTime!,
      currentDish: _dishService.currentDish,
      dishesList: _dishService.dishList,
      breakfastCalories: _foodService.totalBreakfast,
      lunchCalories: _foodService.totalLunch,
      dinnerCalories: _foodService.totalDinner,
      totalGlass: _waterService.totalGlass,
      snackCalories: _foodService.totalSnack,
      totalBreakfastProteins: _foodService.totalBreakfastProteins,
      totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
      totalBreakfastFats: _foodService.totalBreakfastCarbs,
      totalDinnerProteins: _foodService.totalDinnerProteins,
      totalDinnerCarbs: _foodService.totalDinnerCarbs,
      totalDinnerFats: _foodService.totalDinnerFats,
      totalLunchCarbs: _foodService.totalLunchCarbs,
      totalLunchProteins: _foodService.totalLunchProteins,
      totalLunchFats: _foodService.totalLunchFats,
      totalSnackCarbs: _foodService.totalSnackCarbs,
      totalSnackFats: _foodService.totalSnackFats,
      totalSnackProteins: _foodService.totalSnackProteins,
    );

    notifyListeners();
  }

  Future<void> onWaterRemoved() async {
    await _waterService.deleteFood();
    _state = FoodViewModelState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      totalGlass: _waterService.totalGlass,
      currentDateTime: _foodService.currentDateTime!,
      currentDish: _dishService.currentDish,
      dishesList: _dishService.dishList,
      breakfastCalories: _foodService.totalBreakfast,
      lunchCalories: _foodService.totalLunch,
      dinnerCalories: _foodService.totalDinner,
      snackCalories: _foodService.totalSnack,
      totalBreakfastProteins: _foodService.totalBreakfastProteins,
      totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
      totalBreakfastFats: _foodService.totalBreakfastCarbs,
      totalDinnerProteins: _foodService.totalDinnerProteins,
      totalDinnerCarbs: _foodService.totalDinnerCarbs,
      totalDinnerFats: _foodService.totalDinnerFats,
      totalLunchCarbs: _foodService.totalLunchCarbs,
      totalLunchProteins: _foodService.totalLunchProteins,
      totalLunchFats: _foodService.totalLunchFats,
      totalSnackCarbs: _foodService.totalSnackCarbs,
      totalSnackFats: _foodService.totalSnackFats,
      totalSnackProteins: _foodService.totalSnackProteins,
    );
    notifyListeners();
  }

  Future<void> onWaterAdded(WaterModel model) async {
    await _waterService.setFood(model);
    _state = FoodViewModelState(
      totalCalories: _foodService.totalCalories,
      totalCarbs: _foodService.totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService.totalProteins,
      totalGlass: _waterService.totalGlass,
      currentDateTime: _foodService.currentDateTime!,
      currentDish: _dishService.currentDish,
      dishesList: _dishService.dishList,
      breakfastCalories: _foodService.totalBreakfast,
      lunchCalories: _foodService.totalLunch,
      dinnerCalories: _foodService.totalDinner,
      snackCalories: _foodService.totalSnack,
      totalBreakfastProteins: _foodService.totalBreakfastProteins,
      totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
      totalBreakfastFats: _foodService.totalBreakfastCarbs,
      totalDinnerProteins: _foodService.totalDinnerProteins,
      totalDinnerCarbs: _foodService.totalDinnerCarbs,
      totalDinnerFats: _foodService.totalDinnerFats,
      totalLunchCarbs: _foodService.totalLunchCarbs,
      totalLunchProteins: _foodService.totalLunchProteins,
      totalLunchFats: _foodService.totalLunchFats,
      totalSnackCarbs: _foodService.totalSnackCarbs,
      totalSnackFats: _foodService.totalSnackFats,
      totalSnackProteins: _foodService.totalSnackProteins,
    );
    notifyListeners();
  }

  Future<void> onFoodItemAdded(FoodModel foodModel) async {
    _foodService.setFood(foodModel).then((_) {
      _state = FoodViewModelState(
        totalCalories: _foodService.totalCalories,
        totalCarbs: _foodService.totalCarbs,
        totalFats: _foodService.totalFats,
        totalProteins: _foodService.totalProteins,
        totalGlass: _waterService.totalGlass,
        currentDateTime: _foodService.currentDateTime!,
        currentDish: _dishService.currentDish,
        dishesList: _dishService.dishList,
        breakfastCalories: _foodService.totalBreakfast,
        lunchCalories: _foodService.totalLunch,
        dinnerCalories: _foodService.totalDinner,
        snackCalories: _foodService.totalSnack,
        totalBreakfastProteins: _foodService.totalBreakfastProteins,
        totalBreakfastCarbs: _foodService.totalBreakfastCarbs,
        totalBreakfastFats: _foodService.totalBreakfastCarbs,
        totalDinnerProteins: _foodService.totalDinnerProteins,
        totalDinnerCarbs: _foodService.totalDinnerCarbs,
        totalDinnerFats: _foodService.totalDinnerFats,
        totalLunchCarbs: _foodService.totalLunchCarbs,
        totalLunchProteins: _foodService.totalLunchProteins,
        totalLunchFats: _foodService.totalLunchFats,
        totalSnackCarbs: _foodService.totalSnackCarbs,
        totalSnackFats: _foodService.totalSnackFats,
        totalSnackProteins: _foodService.totalSnackProteins,
      );
      notifyListeners();
    });
  }
}
