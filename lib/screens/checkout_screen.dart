import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'tracking_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Checkout", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Alamat Pengiriman
                _buildSectionHeader("Alamat Pengiriman"),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chairi Septa | (+62) 896-1891-6587", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Jl. Cipocok Jaya No. 16, Serang - Banten", style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Opsi Pengiriman
                _buildSectionHeader("Opsi Pengiriman"),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _buildDeliveryOption("Express < 30 menit", "Rp. 20.000", true),
                      const Divider(height: 1),
                      _buildDeliveryOption("Reguler - 40 menit", "Rp. 18.000", false),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Daftar Item Resto
                _buildSectionHeader("Mie Gacoan - Jendral Sudirman Serang"),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Item 1: Mie Gacoan
                      _buildItemRow("assets/images/foto_gacoan.png", "Mie Gacoan", "Level 1", "Rp. 15.000", "2"),
                      const SizedBox(height: 12),
                      // Item 2: Udang Keju
                      _buildItemRow("assets/images/udangkeju.jpg", "Udang keju", "Tambahan catatan...", "Rp. 14.500", "3"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Rincian Pembayaran
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: const Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Harga"), Text("Rp. 73.500")]),
                      SizedBox(height: 6),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Biaya Penanganan & Pengiriman"), Text("Rp. 18.000")]),
                      SizedBox(height: 6),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Biaya Lainnya"), Text("Rp. 1.000")]),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pembayaran", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Rp. 92.500", style: TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Order Action Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPink,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TrackingScreen()),
                  );
                },
                child: const Text("Pesan dan Antar Sekarang", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 13)),
    );
  }

  Widget _buildDeliveryOption(String title, String price, bool isSelected) {
    return ListTile(
      leading: Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? AppColors.primaryPink : Colors.grey),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  // Perubahan: Menambahkan parameter imagePath di awal fungsi
  Widget _buildItemRow(String imagePath, String title, String subtitle, String price, String qty) {
    return Row(
      children: [
        // Wadah Gambar Produk yang Diperbarui
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6), // Membuat sudut wadah sedikit melengkung
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, // Gambar mengisi penuh area 50x50 tanpa merusak aspek rasio
              errorBuilder: (context, error, stackTrace) {
                // Tampilan cadangan jika file gambar tidak ditemukan/gagal dimuat
                return const Icon(Icons.fastfood, color: Colors.grey, size: 20);
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 4),
              Text(price, style: const TextStyle(color: AppColors.primaryPink, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Text("x$qty", style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}