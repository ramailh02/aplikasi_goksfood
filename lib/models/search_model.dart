class FoodModel {
  final String name;
  final String price;
  final double rating;
  final String duration;
  final String image; // Properti untuk path asset gambar

  FoodModel({
    required this.name,
    required this.price,
    required this.rating,
    required this.duration,
    required this.image,
  });
}

// Data Dummy dipisahkan di sini (atau bisa dibuat berkas khusus food_dummy.dart)
List<FoodModel> dummyFoods = [
  FoodModel(
    name: "Mie Gacoan",
    price: "15.000",
    rating: 4.8,
    duration: "10-15 mnt",
    image: "assets/images/foto_gacoan.png",
  ),
  FoodModel(
    name: "Nasi Goreng Ayam",
    price: "20.000",
    rating: 4.5,
    duration: "15-20 mnt",
    image: "assets/images/nasgor.png",
  ),
  FoodModel(
    name: "Labaik Chicken",
    price: "17.000",
    rating: 4.6,
    duration: "12-18 mnt",
    image: "assets/images/labaik.png",
  ),
  FoodModel(
    name: "Kopi Kenangan",
    price: "30.000",
    rating: 4.9,
    duration: "12 mnt",
    image: "assets/images/foto_kenangan.png",
  ),
   FoodModel(
    name: "Burger King",
    price: "30.000",
    rating: 4.9,
    duration: "12 - 15 mnt",
    image: "assets/images/burgerking.jpg",
  ),
   FoodModel(
    name: "Fore",
    price: "35.000",
    rating: 4.9,
    duration: "12 mnt",
    image: "assets/images/fore.png",
  ),
];