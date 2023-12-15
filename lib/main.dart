import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/models/item_food.dart';
import 'package:food_app_example/models/restaurant.dart';
import 'package:food_app_example/pages/sc1_lobby.dart';
import 'package:food_app_example/services/firebase_functions.dart';
/*List<Restaurant> res = [
  Restaurant(id: "10", imagePath: ImgAsset.DogMeat, title: "Beefsteak", description: "Bình thường", reviews: "332", isFavorite: false),
  Restaurant(id: "20", imagePath: ImgAsset.Pizza, title: "Pizza", description: "Bình thường", reviews: "258", isFavorite: false),
  Restaurant(id: "30", imagePath: ImgAsset.Hamburger, title: "Hamburger", description: "Không ngon", reviews: "172", isFavorite: false),
  Restaurant(id: "40", imagePath: ImgAsset.ComTam, title: "Cơm tấm", description: "Ngon", reviews: "889", isFavorite: false),
  Restaurant(id: "50", imagePath: ImgAsset.Sushi, title: "Sushi", description: "Dở", reviews: "87", isFavorite: false)
];
List<ItemFood> fud = [
  //thit cho
  ItemFood(idRestaurant: "10", imagePathFood: ImgAsset.DogMeatNuong, nameFood: "Thịt chó nướng", cost: "80"),
  ItemFood(idRestaurant: "10", imagePathFood: ImgAsset.DogMeatDoiCho, nameFood: "Dồi chó", cost: "50"),
  ItemFood(idRestaurant: "10", imagePathFood: ImgAsset.DogMeatHap, nameFood: "Thịt chó hấp", cost: "100"),
  ItemFood(idRestaurant: "10", imagePathFood: ImgAsset.DogMeat7Mon, nameFood: "Chó 7 món", cost: "180"),
  //hambur
  ItemFood(idRestaurant: "20", imagePathFood: ImgAsset.PizzaBeef, nameFood: "Pizza nướng", cost: "130"),
  ItemFood(idRestaurant: "20", imagePathFood: ImgAsset.PizzaChay, nameFood: "Pizza chay", cost: "100"),
  ItemFood(idRestaurant: "20", imagePathFood: ImgAsset.PizzaChicken, nameFood: "Pizza thịt gà", cost: "150"),
  ItemFood(idRestaurant: "20", imagePathFood: ImgAsset.Pizza, nameFood: "Pizza thờng", cost: "80"),
  //com tam
  ItemFood(idRestaurant: "30", imagePathFood: ImgAsset.HamburgerFullCombo, nameFood: "Hamburger đầy đủ", cost: "150"),
  ItemFood(idRestaurant: "30", imagePathFood: ImgAsset.HamburgerWithBeer, nameFood: "Hamburger và bia", cost: "130"),
  ItemFood(idRestaurant: "30", imagePathFood: ImgAsset.HamburgerWithCola, nameFood: "Hamburger và CocaCola", cost: "120"),
  ItemFood(idRestaurant: "30", imagePathFood: ImgAsset.HamburgerWithPotato, nameFood: "Hamburger và khoai tây", cost: "90"),
  //pizza
  ItemFood(idRestaurant: "40", imagePathFood: ImgAsset.ComTamThapCam, nameFood: "Cơm tấm thập cẩm", cost: "180"),
  ItemFood(idRestaurant: "40", imagePathFood: ImgAsset.ComTamThitBo, nameFood: "Cơm tấm thịt bò", cost: "150"),
  ItemFood(idRestaurant: "40", imagePathFood: ImgAsset.ComTamThitGa, nameFood: "Cơm tấm thịt gà", cost: "130"),
  ItemFood(idRestaurant: "40", imagePathFood: ImgAsset.ComTamThitHeo, nameFood: "Cơm tấm thịt heo", cost: "140"),
  //sushi
  ItemFood(idRestaurant: "50", imagePathFood: ImgAsset.SushiLunch, nameFood: "Sushi loại 1", cost: "180"),
  ItemFood(idRestaurant: "50", imagePathFood: ImgAsset.SushiLunchCombo, nameFood: "Sushi loại 2", cost: "150"),
  ItemFood(idRestaurant: "50", imagePathFood: ImgAsset.SushiLunchOtovior, nameFood: "Sushi loại 3", cost: "160"),
  ItemFood(idRestaurant: "50", imagePathFood: ImgAsset.SushiRolls, nameFood: "Sushi loại 4", cost: "100")
];*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // addFoodItems(fud);
  // addFoodList(res);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Sc1Lobby(),
      debugShowCheckedModeBanner: false,
    );
  }
}
