import 'package:hive/hive.dart';
import 'package:tt_28/features/home/model/food_model.dart';

part 'recepi.g.dart';

@HiveType(typeId: 4)
class Ingredient {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int grams;

  Ingredient({required this.name, required this.grams});
}

@HiveType(typeId: 6)
class Recipe {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int calories;

  @HiveField(3)
  final int cookingTime;

  @HiveField(4)
  final bool isFavorite;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final FoodType foodType;

  @HiveField(7)
  final List<Ingredient> ingredients;

  Recipe({
    required this.imagePath,
    required this.name,
    required this.calories,
    required this.cookingTime,
    required this.isFavorite,
    required this.description,
    required this.foodType,
    required this.ingredients,
  });
}
