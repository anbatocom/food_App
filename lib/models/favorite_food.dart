import 'package:json_annotation/json_annotation.dart';
part 'favorite_food.g.dart';
@JsonSerializable()
class FavoriteFood {
  final String idUser;
  final String idRestaurant;
  FavoriteFood({
    required this.idUser,
    required this.idRestaurant,
  });
  factory FavoriteFood.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFoodFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteFoodToJson(this);
  
}
