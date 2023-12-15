import 'package:json_annotation/json_annotation.dart';
part 'restaurant.g.dart';
@JsonSerializable()
class Restaurant {
  final String id;
  final String imagePath;
  final String title;
  final String description;
  final String reviews;
  bool isFavorite;

  Restaurant({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.reviews,
    required this.isFavorite,
  }); 
  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
