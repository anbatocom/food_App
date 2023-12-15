// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      reviews: json['reviews'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'title': instance.title,
      'description': instance.description,
      'reviews': instance.reviews,
      'isFavorite': instance.isFavorite,
    };
