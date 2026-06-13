import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Keranjang", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Item 1: Mie Gacoan
                _buildCartItem(
                  "assets/images/foto_gacoan.png", 
                  "Mie Gacoan", 
                  "Level 1", 
                  "Rp. 15.000", 
                  "2"
                ),
                const SizedBox(height: 16),
                
                // Item 2: Udang Keju
                _buildCartItem(
                  "assets/images/udangkeju.jpg", 
                  "Udang keju", 
                  "Tambahan catatan...", 
                  "Rp. 14.500", 
                  "3"
                ),
              ],
            ),
          ),
          
          // Bottom Payment Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2), 
                  spreadRadius: 1, 
                  blurRadius: 5, 
                  offset: const Offset(0, -2)
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Total:", style: TextStyle(color: Colors.black54, fontSize: 14)),
                    Text("Rp. 74.500", style: TextStyle(color: AppColors.primaryPink, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                    );
                  },
                  child: const Text("Checkout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Perubahan: Menambahkan parameter imagePath di awal fungsi
  Widget _buildCartItem(String imagePath, String title, String subtitle, String price, String qty) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Container Gambar Produk
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300], 
              borderRadius: BorderRadius.circular(8),
            ),
            // Menggunakan ClipRRect agar gambar mengikuti kelengkungan border radius kontainer
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Membuat gambar terpotong rapi memenuhi kontainer 70x70
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika file gambar tidak ditemukan atau gagal dimuat
                  return const Icon(Icons.fastfood, color: Colors.grey);
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Text(price, style: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.remove_circle_outline, color: AppColors.primaryPink, size: 20)
              ),
              Text(qty, style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.add_circle, color: AppColors.primaryPink, size: 20)
              ),
            ],
          )
        ],
      ),
    );
  }
}