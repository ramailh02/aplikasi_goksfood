import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'login_screen.dart'; // Memastikan import file login sudah benar

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State untuk menyimpan status tema (false = Terang, true = Gelap)
  bool _isDarkMode = false;

  // Fungsi untuk menangani aksi logout dan mengarahkannya ke halaman login
  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Keluar"),
          content: const Text("Apakah Anda yakin ingin keluar dari akun?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Menutup dialog jika batal
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog konfirmasi terlebih dahulu
                
                // Menampilkan notifikasi singkat
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Berhasil keluar")),
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()), 
                  (route) => false, // Menghapus seluruh tumpukan halaman agar tidak bisa di-back
                );
              },
              child: Text("Keluar", style: TextStyle(color: AppColors.primaryPink)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkMode ? Colors.black87 : (Colors.grey[50] ?? const Color(0xFFFAFAFA));
    final surfaceColor = _isDarkMode ? (Colors.grey[900] ?? const Color(0xFF212121)) : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final subTextColor = _isDarkMode ? (Colors.grey[400] ?? Colors.grey) : (Colors.grey[600] ?? Colors.grey);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: textColor),
        title: Text(
          "Profile", 
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Header dengan Image Asset
            Container(
              color: surfaceColor,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: _isDarkMode ? (Colors.grey[800] ?? Colors.grey) : (Colors.grey[200] ?? Colors.grey),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/images/chairil.jpeg", 
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person, size: 40, color: subTextColor);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chairi Septa", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                      ),
                      Text(
                        "chairi@gmail.com", 
                        style: TextStyle(color: subTextColor, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Section Akun
            _buildSectionTitle("Akun"),
            _buildProfileTile(Icons.person_outline, "Kelola Profil", surfaceColor, textColor),
            _buildProfileTile(Icons.lock_outline, "Kata Sandi & Keamanan", surfaceColor, textColor),
            _buildProfileTile(Icons.notifications_none, "Pemberitahuan", surfaceColor, textColor),
            _buildProfileTile(Icons.language, "Bahasa", surfaceColor, textColor, trailingText: "Indonesia"),
            
            // Section Preferensi
            _buildSectionTitle("Preferensi"),
            _buildProfileTile(Icons.info_outline, "Tentang Kami", surfaceColor, textColor),
            
            // Tampilan (Bisa diklik untuk mengubah tema)
            _buildProfileTile(
              Icons.dark_mode_outlined, 
              "Tampilan", 
              surfaceColor, 
              textColor,
              trailingText: _isDarkMode ? "Gelap" : "Terang",
              onTap: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),

            // Section Dukungan
            _buildSectionTitle("Dukungan & Tentang"),
            _buildProfileTile(Icons.help_outline, "Pusat Bantuan", surfaceColor, textColor),
            _buildProfileTile(Icons.privacy_tip_outlined, "Pusat Privasi", surfaceColor, textColor),

            // Section Login
            _buildSectionTitle("Login"),
            _buildProfileTile(Icons.switch_account_outlined, "Beralih Akun", surfaceColor, textColor),
            
            // Keluar (Bisa diklik)
            _buildProfileTile(
              Icons.logout, 
              "Keluar", 
              surfaceColor, 
              AppColors.primaryPink,
              textColorCustom: AppColors.primaryPink,
              onTap: _handleLogout,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProfileTile(
    IconData icon, 
    String title, 
    Color tileColor, 
    Color defaultTextColor, 
    {String? trailingText, 
    Color? textColorCustom, 
    VoidCallback? onTap}
  ) {
    return Container(
      color: tileColor,
      child: ListTile(
        leading: Icon(icon, color: textColorCustom ?? defaultTextColor),
        title: Text(title, style: TextStyle(color: textColorCustom ?? defaultTextColor, fontSize: 15)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Text(trailingText, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: onTap ?? () {},
      ),
    );
  }
}