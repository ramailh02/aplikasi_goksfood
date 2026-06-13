class FoodItem {
  final String name;
  final String image; // Menggunakan path lokal, misal: 'assets/images/mcd.jpg'
  final int price;
  final double rating;
  final String duration;
  final String distance;

  FoodItem({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.duration,
    required this.distance,
  });
}

// Data Dummy untuk FoodItem
List<FoodItem> dummyFoods = [
  FoodItem(
    name: "McDonald's, Ciceri Serang", 
    image: "assets/images/mcd.jpg",
    price: 35000, 
    rating: 4.8, 
    duration: "15-25 Min",
    distance: "2.57 Km",
  ),
  FoodItem(
    name: "Cruz Coffe & Work Space", 
    image: "assets/images/cruz.jpeg",
    price: 28000, 
    rating: 4.8, 
    duration: "20-30 Min",
    distance: "4.02 Km",
  ),
  FoodItem(
    name: "Mie Gacoan", 
    image: "assets/images/poster.jpeg", 
    price: 15500, 
    rating: 4.7, 
    duration: "15-20 Min",
    distance: "1.20 Km",
  ),
  FoodItem(
    name: "Baso Mas Jum 354", 
    image: "assets/images/bakso.png", 
    price: 20000, 
    rating: 4.7, 
    duration: "10-20 Min",
    distance: "0.80 Km",
  ),
];