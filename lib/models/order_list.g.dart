// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderList _$OrderListFromJson(Map<String, dynamic> json) => OrderList(
      idUser: json['idUser'] as String,
      imageOrderPath: json['imageOrderPath'] as String,
      nameRestaurant: json['nameRestaurant'] as String,
      orderTime: DateTime.parse(json['orderTime'] as String),
      optionOrdering: json['optionOrdering'] as String,
      cost: (json['cost'] as num).toDouble(),
      foodOrdered: json['foodOrdered'] as List<dynamic>,
      dayOrder: DateTime.parse(json['dayOrder'] as String),
      timeOrder: json['timeOrder'] as String,
    );

Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
      'idUser': instance.idUser,
      'imageOrderPath': instance.imageOrderPath,
      'nameRestaurant': instance.nameRestaurant,
      'optionOrdering': instance.optionOrdering,
      'dayOrder': instance.dayOrder.toIso8601String(),
      'timeOrder': instance.timeOrder,
      'orderTime': instance.orderTime.toIso8601String(),
      'foodOrdered': instance.foodOrdered,
      'cost': instance.cost,
    };
