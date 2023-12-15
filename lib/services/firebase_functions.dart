import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_example/models/favorite_food.dart';
import 'package:food_app_example/models/item_food.dart';
import 'package:food_app_example/models/restaurant.dart';

Future<void> addFavoriteRestaurantList(List<FavoriteFood> items) async {
  try {
    CollectionReference itemsCollection =
        FirebaseFirestore.instance.collection('favorite');
    DocumentReference itemDoc =
        itemsCollection.doc(FirebaseAuth.instance.currentUser!.email);

    // Retrieve the current data
    DocumentSnapshot documentSnapshot = await itemDoc.get();
    Map<String, dynamic> currentData =
        documentSnapshot.data() as Map<String, dynamic>? ?? {};

    // Convert the new items to a list of maps
    List<Map<String, dynamic>> itemsData =
        items.map((item) => item.toJson()).toList();

    // Merge the new items into the existing data
    currentData['favorite'] = [...currentData['favorite'] ?? [], ...itemsData];

    // Set the updated data to Firestore
    await itemDoc.set(currentData, SetOptions(merge: true));
    debugPrint("Danh sách các mục đã được thêm vào Firebase.");
  } catch (e) {
    debugPrint("Lỗi khi thêm danh sách các mục: $e");
  }
}

Future<void> deleteFavoriteRestaurantList(String itemId) async {
  try {
    // Tham chiếu đến tài liệu cụ thể trong Firestore
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.email);

    // Lấy dữ liệu hiện tại của tài liệu
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      // Lấy dữ liệu hiện tại của trường chứa mảng hoặc map
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      // Xoá phần tử dựa trên id
      data['favorite'].removeWhere((item) => item['idRestaurant'] == itemId);

      // Cập nhật lại tài liệu trên Firestore
      await documentReference.update({'favorite': data['favorite']});
    }
  } catch (e) {
    print('Error removing item: $e');
  }
}

Future<Map<String, dynamic>> getFavoriteItemsByUid(String? uid) async {
  try {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('favorite').doc(uid).get();

    if (documentSnapshot.exists) {
      // Trả về dữ liệu của tài liệu
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      // Trả về một giá trị mặc định hoặc thông báo rỗng tùy thuộc vào yêu cầu của bạn
      return {};
    }
  } catch (e) {
    print('Error getting favorite items: $e');
    // Xử lý lỗi theo ý của bạn, ví dụ: trả về một giá trị mặc định hoặc thông báo rỗng
    return {};
  }
}

Future<void> updateRestaurant(List<ItemFood> items, String documentId) async {
  try {
    DocumentReference itemsDocument =
        FirebaseFirestore.instance.collection('foods').doc(documentId);

    // Lấy danh sách hiện tại từ Firestore
    DocumentSnapshot documentSnapshot = await itemsDocument.get();
    List<Map<String, dynamic>> existingItemsData = [];
    final data = documentSnapshot.data();
    if (data != null && data is Map && data.containsKey('foods')) {
      final itemsDynamic = data['foods'];
      if (itemsDynamic != null && itemsDynamic is List) {
        existingItemsData = List<Map<String, dynamic>>.from(
          (itemsDynamic).cast<Map<String, dynamic>>(),
        );
      }
    }
    // Thêm dữ liệu mới vào danh sách hiện tại
    List<Map<String, dynamic>> updatedItemsData = [
      ...existingItemsData,
      ...items.map((item) => item.toJson()).toList()
    ];

    await itemsDocument.update({
      'foods': updatedItemsData,
    });

    print("Danh sách các mục đã được thêm vào Firebase.");
  } catch (e) {
    print("Lỗi khi thêm danh sách các mục: $e");
  }
}

Future<void> addFoodItems(List<ItemFood> foods) async {
  try {
    CollectionReference foodsCollection =
        FirebaseFirestore.instance.collection("foods");
    List<Map<String, dynamic>> foodsData =
        foods.map((food) => food.toJson()).toList();
    await foodsCollection.add({
      'foods': foodsData,
    });
    print("Danh sách các mục đã được thêm vào Firebase.");
  } catch (e) {
    print("Lỗi khi thêm danh sách các mục: $e");
  }
}

Future<void> addFoodList(List<Restaurant> items) async {
  try {
    CollectionReference foodsCollection =
    FirebaseFirestore.instance.collection("items");
    List<Map<String, dynamic>> itemsData =
    items.map((item) => item.toJson()).toList();
    await foodsCollection.add({
      'items': itemsData,
    });
    print("Danh sách các mục đã được thêm vào Firebase.");
  } catch (e) {
    print("Lỗi khi thêm danh sách các mục: $e");
  }
}

Future<void> updateFavoriteStatus(
    String documentId, String itemId, bool isFavorite) async {
  try {
    // Thực hiện truy vấn để lấy DocumentReference
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("items").doc(documentId);

    // Lấy dữ liệu hiện tại của trường 'items'
    DocumentSnapshot snapshot = await docRef.get();

    // Lấy danh sách items từ dữ liệu hiện tại
    List<dynamic> itemsData = snapshot['items'];

    // Tìm kiếm mục cần cập nhật trong danh sách
    int index = itemsData.indexWhere((item) => item['id'] == itemId);

    if (index != -1) {
      // Cập nhật trường 'isFavorite' của mục cụ thể
      itemsData[index]['isFavorite'] = isFavorite;

      // Cập nhật dữ liệu cụ thể trong Firestore
      await docRef.update({'items': itemsData});

      print("Cập nhật dữ liệu thành công");
    } else {
      print("Không tìm thấy mục với id $itemId");
    }
  } catch (e) {
    print("Lỗi khi cập nhật dữ liệu: $e");
  }
}
