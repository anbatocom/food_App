import 'package:json_annotation/json_annotation.dart';
part 'order_list.g.dart';

@JsonSerializable()
class OrderList {
  final String idUser;
  final String imageOrderPath;
  final String nameRestaurant;
  final String optionOrdering;
  final DateTime dayOrder;
  final String timeOrder;
  final DateTime orderTime;
  final List<dynamic> foodOrdered;
  final double cost;
  OrderList({
    required this.idUser,
    required this.imageOrderPath,
    required this.nameRestaurant,
    required this.orderTime,
    required this.optionOrdering,
    required this.cost,
    required this.foodOrdered,
    required this.dayOrder,
    required this.timeOrder,
  });
  factory OrderList.fromJson(Map<String, dynamic> json) =>
      _$OrderListFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListToJson(this);
}
