import 'package:hive/hive.dart';
import 'package:tt_28/features/home/model/food_model.dart';

class DishService {
  List<FoodModel?> _dishList = [];
  FoodType _foodType = FoodType.breakfast;
  bool _isShowFavorite = false;
  FoodModel? _currentDish;
  List<FoodModel?> get dishList => _dishList;
  FoodModel? get currentDish => _currentDish;
  FoodType get foodType => _foodType;

  Future<void> loadData() async {
    final foodModelBox = await Hive.openBox<FoodModel>('_dishList');
    _dishList = foodModelBox.values.where((e) {
      return e.typeOfFood == _foodType && _isShowFavorite == e.isFavorite;
    }).toList();
  }

  Future<void> changeTab(bool tab) async {
    _isShowFavorite = tab;
    loadData();
  }

  Future<void> loadDataWithFoodType(FoodType foodType) async {
    _foodType = foodType;
    loadData();
  }

  void getDishById(int id) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_dishList');

    if (foodModelBox.values.toList().isNotEmpty) {
      _currentDish = foodModelBox.values.toList().singleWhere(
        (food) {
          return food.id == id;
        },
      );
    }
  }

  Future<void> setFood(FoodModel foodModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_dishList');
    await foodModelBox.add(foodModel);

    await loadData();
  }

  Future<void> deleteFood(FoodModel foodModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_dishList');
    final foodModelList = foodModelBox.values.toList();
    if (foodModelList.contains(foodModel)) {
      _dishList.remove(foodModel);
      await foodModelBox.delete(foodModel);
    }
  }

  Future<void> editFood(FoodModel foodEditModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_dishList');
    FoodModel newMoaqw =
        foodModelBox.values.singleWhere((e) => e.id == foodEditModel.id);

    newMoaqw.isFavorite = foodEditModel.isFavorite;
    newMoaqw.portion = foodEditModel.portion;
    newMoaqw.quantity = foodEditModel.quantity;

    await newMoaqw.save();
    await loadData();
  }
}
