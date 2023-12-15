import 'package:json_annotation/json_annotation.dart';
part 'item_food.g.dart';

@JsonSerializable()
class ItemFood {
  final String idRestaurant;
  final String imagePathFood;
  final String nameFood;
  final String cost;
  ItemFood({
    required this.idRestaurant,
    required this.imagePathFood,
    required this.nameFood,
    required this.cost,
  });
  factory ItemFood.fromJson(Map<String, dynamic> json) =>
      _$ItemFoodFromJson(json);
  Map<String, dynamic> toJson() => _$ItemFoodToJson(this);
  String toString() {
    return 'ItemFood{id: $idRestaurant, nameFood: $nameFood, cost: $cost, ImagePath: $imagePathFood}';
  }
    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemFood &&
        other.idRestaurant == idRestaurant &&
        other.imagePathFood == imagePathFood &&
        other.nameFood == nameFood &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return idRestaurant.hashCode ^ imagePathFood.hashCode ^ nameFood.hashCode ^ cost.hashCode;
  }
}
