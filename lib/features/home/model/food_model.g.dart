part of 'food_model.dart';

class FoodModelAdapter extends TypeAdapter<FoodModel> {
  @override
  final int typeId = 0;

  @override
  FoodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodModel(
      id: fields[0] as int?,
      typeOfFood: fields[1] as FoodType,
      name: fields[8] as String,
      date: fields[2] as DateTime,
      quantity: fields[3] as double,
      portion: fields[10] as int,
      calories: fields[4] as double,
      proteins: fields[5] as double,
      fats: fields[6] as double,
      carbs: fields[7] as double,
      isFavorite: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FoodModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeOfFood)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.calories)
      ..writeByte(5)
      ..write(obj.proteins)
      ..writeByte(6)
      ..write(obj.fats)
      ..writeByte(7)
      ..write(obj.carbs)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.portion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FoodTypeAdapter extends TypeAdapter<FoodType> {
  @override
  final int typeId = 2;

  @override
  FoodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FoodType.breakfast;
      case 1:
        return FoodType.lunch;
      case 2:
        return FoodType.dinner;
      case 3:
        return FoodType.snack;
      default:
        return FoodType.breakfast;
    }
  }

  @override
  void write(BinaryWriter writer, FoodType obj) {
    switch (obj) {
      case FoodType.breakfast:
        writer.writeByte(0);
        break;
      case FoodType.lunch:
        writer.writeByte(1);
        break;
      case FoodType.dinner:
        writer.writeByte(2);
        break;
      case FoodType.snack:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
