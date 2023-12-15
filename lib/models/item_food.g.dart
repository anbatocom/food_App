// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemFood _$ItemFoodFromJson(Map<String, dynamic> json) => ItemFood(
      idRestaurant: json['idRestaurant'] as String,
      imagePathFood: json['imagePathFood'] as String,
      nameFood: json['nameFood'] as String,
      cost: json['cost'] as String,
    );

Map<String, dynamic> _$ItemFoodToJson(ItemFood instance) => <String, dynamic>{
      'idRestaurant': instance.idRestaurant,
      'imagePathFood': instance.imagePathFood,
      'nameFood': instance.nameFood,
      'cost': instance.cost,
    };
