import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Integrasi Peta Dummy Interaktif (Pengganti Google Maps)
          _buildDummyMap(),

          // Tombol Back di atas Peta
          Positioned(
            top: 44,
            left: 16,
            child: Material(
              type: MaterialType.circle,
              elevation: 4,
              shadowColor: Colors.black26,
              color: Colors.white,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // 2. Bottom Sheet Konten Pelacakan
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.52,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Indikator garis kecil di atas sheet
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Estimasi Waktu Tiba & Voucher
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Estimasi tiba dalam: 10 menit", 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Dapat Voucher Rp. 10.000 jika pesanan belum tiba s.d 11.10",
                          style: TextStyle(color: Colors.grey[600], fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),

                  // Profil Driver Info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[200],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              "assets/images/ramdhan.jpeg",
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, color: Colors.grey, size: 28);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Ram Van Dhan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 14),
                                  Text(" (4.9)", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Tombol Telepon & Pesan teks
                        IconButton(
                          icon: const Icon(Icons.phone_in_talk, color: Colors.black87),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: Colors.black87),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Status Alur Timeline Pesanan
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      children: [
                        _buildTimelineRow(
                          icon: Icons.restaurant,
                          title: "Pesanan Dibuat, Menunggu pesanan diserahkan kepihak jasa kirim.",
                          isCompleted: true,
                          showLine: true,
                        ),
                        _buildTimelineRow(
                          icon: Icons.motorcycle,
                          title: "Pesanan sedang dalam perjalanan,\nMohon ditunggu.",
                          isCompleted: true,
                          showLine: true,
                        ),
                        _buildTimelineRow(
                          icon: Icons.location_on,
                          title: "Makanan sedang diantar ke tempat anda.",
                          isCompleted: false,
                          showLine: false,
                        ),
                      ],
                    ),
                  ),

                  // Tombol Konfirmasi Akhir bawah
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        child: const Text("Pesanan Diterima", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget Pembuat Struktur Peta Tiruan (Dummy Map Layout)
  Widget _buildDummyMap() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFE8F5E9), // Warna latar hijau muda khas peta luar ruangan
      child: Stack(
        children: [
          // Ilustrasi Grid Jalan Raya Tiruan (Horizontal & Vertikal)
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Container(height: 40, color: Colors.white),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 120,
            child: Container(width: 40, color: Colors.white),
          ),
          Positioned(
            top: 140,
            left: 120,
            right: 0,
            child: Container(height: 35, color: Colors.white),
          ),

          // Representasi Garis Rute Perjalanan Pengantaran (Polyline Simulasi)
          Positioned(
            top: 155,
            left: 138,
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: CustomPaint(
              size: const Size(200, 150),
              painter: DashLinePainter(),
            ),
          ),

          // Ikon Penanda: Lokasi Rumah (Tujuan Akhir)
          Positioned(
            top: 130,
            right: 60,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: const Text("Rumah Anda", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const Icon(Icons.location_on, color: Colors.red, size: 36),
              ],
            ),
          ),

          // Ikon Penanda Dinamis: Lokasi Kurir/Driver (Bisa Bergerak Lambat)
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 4),
            builder: (context, value, child) {
              // Pergerakan kalkulasi koordinat widget di dalam layar
              double currentTop = 320 - (value * 150); 
              return Positioned(
                top: currentTop,
                left: 122,
                child: child!,
              );
            },
            child: const Icon(Icons.motorcycle, color: Colors.blue, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineRow({required IconData icon, required String title, required bool isCompleted, bool showLine = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primaryPink.withValues(alpha: 0.15) : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isCompleted ? AppColors.primaryPink : Colors.grey, size: 20),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? AppColors.primaryPink : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                height: 1.3,
                fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
                color: isCompleted ? Colors.black87 : Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom Painter khusus untuk membuat garis rute belok putus-putus
class DashLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    var max = 130;
    var dashWidth = 5;
    var dashSpace = 5;
    double startY = max.toDouble();
    
    // Menggambar jalur lurus naik ke atas
    while (startY >= 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY - dashWidth), paint);
      startY -= dashWidth + dashSpace;
    }
    // Menggambar jalur belok kanan menuju rumah tujuan
    double startX = 0;
    while (startX <= 130) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}