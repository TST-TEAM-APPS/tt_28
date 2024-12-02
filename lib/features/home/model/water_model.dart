import 'package:hive/hive.dart';

part 'water_model.g.dart';

@HiveType(typeId: 3)
class WaterModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime createdDate;
  @HiveField(2)
  int quantity;

  WaterModel({
    int? id,
    required this.createdDate,
    required this.quantity,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch;
}
