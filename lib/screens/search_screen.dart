import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/search_model.dart';
import 'detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            "Search",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Lagi mau makan apa?",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grid Daftar Makanan Hasil Search
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68, // DIUBAH: Dari 0.75 ke 0.68 agar Card memanjang ke bawah dan memberikan ruang untuk gambar yang lebih besar
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: dummyFoods.length,
                itemBuilder: (context, index) {
                  final food = dummyFoods[index];
                  return GestureDetector(
                    onTap: () {
                      if (food.name == "Mie Gacoan") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailScreen()),
                        );
                      }
                    },
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Menampilkan Image Asset dengan ClipRRect agar melengkung di sudut atas
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: SizedBox(
                              height: 125, // DIUBAH: Dari 100 ke 125 agar ukuran gambar menjadi lebih besar dan dominan
                              width: double.infinity,
                              child: Image.asset(
                                food.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(Icons.fastfood, color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name, 
                                  style: const TextStyle(fontWeight: FontWeight.bold), 
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rp ${food.price}", 
                                  style: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    Text(" ${food.rating}", style: const TextStyle(fontSize: 12)),
                                    const Spacer(),
                                    const Icon(Icons.access_time, color: Colors.grey, size: 14),
                                    Text(" ${food.duration}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}