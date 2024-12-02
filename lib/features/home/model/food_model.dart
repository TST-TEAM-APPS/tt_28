// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'food_model.g.dart';

@HiveType(typeId: 2)
enum FoodType {
  @HiveField(0)
  breakfast,
  @HiveField(1)
  lunch,
  @HiveField(2)
  dinner,
  @HiveField(3)
  snack,
}

@HiveType(typeId: 0)
class FoodModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  FoodType typeOfFood;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  double quantity;
  @HiveField(4)
  double calories;
  @HiveField(5)
  double proteins;
  @HiveField(6)
  double fats;
  @HiveField(7)
  double carbs;
  @HiveField(8)
  String name;
  @HiveField(9)
  bool isFavorite;
  @HiveField(10)
  int portion;

  FoodModel(
      {int? id,
      required this.typeOfFood,
      required this.name,
      required this.date,
      required this.quantity,
      this.portion = 1,
      required this.calories,
      required this.proteins,
      required this.fats,
      required this.carbs,
      required this.isFavorite})
      : id = id ?? DateTime.now().microsecondsSinceEpoch;
  @override
  bool operator ==(covariant FoodModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.typeOfFood == typeOfFood &&
        other.date == date &&
        other.quantity == quantity &&
        other.calories == calories &&
        other.proteins == proteins &&
        other.fats == fats &&
        other.carbs == carbs;
  }

  FoodModel copyWith({
    int? id,
    FoodType? typeOfFood,
    DateTime? date,
    double? quantity,
    double? calories,
    double? proteins,
    double? fats,
    double? carbs,
    String? name,
  }) {
    return FoodModel(
      id: this.id,
      typeOfFood: typeOfFood ?? this.typeOfFood,
      name: name ?? this.name,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      fats: fats ?? this.fats,
      carbs: carbs ?? this.carbs,
      isFavorite: isFavorite,
    );
  }
}
