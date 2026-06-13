import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoginMode = true;  
  bool _isPasswordObscured = true;

  // Variabel untuk memantau apakah tombol boleh aktif atau tidak
  bool _isButtonEnabled = false;

  final List<String> _registeredEmails = ["ramdhan@gmail.com", "chairi@gmail.com"];
  final Map<String, String> _registeredPasswords = {
    "ramdhan@gmail.com": "ramdhan123",
    "chairi@gmail.com": "chairi123"
  };

  @override
  void initState() {
    super.initState();
    // Tambahkan listener pada controller untuk mendeteksi setiap ketikan user
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk cek apakah kolom email & password sudah ada isinya
  void _validateForm() {
    setState(() {
      _isButtonEnabled = _emailController.text.trim().isNotEmpty && 
                         _passwordController.text.isNotEmpty;
    });
  }

  // Fungsi Logika utama saat tombol ditekan
  void _handleSubmit() {
    String inputEmail = _emailController.text.trim();
    String inputPassword = _passwordController.text;

    // Validasi format email standar
    bool isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(inputEmail);
    if (!isValidEmail) {
      _showSnackBar("Format email tidak valid! Contoh: user@email.com", Colors.orange);
      return;
    }

    if (_isLoginMode) {
      // --- PROSES LOGIN ---
      if (_registeredEmails.contains(inputEmail) && _registeredPasswords[inputEmail] == inputPassword) {
        _showSnackBar("Login Berhasil!", Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      } else {
        _showSnackBar("Email atau Password salah!", Colors.redAccent);
      }
    } else {
      // --- PROSES SIGN UP ---
      setState(() {
        _registeredEmails.add(inputEmail);
        _registeredPasswords[inputEmail] = inputPassword;
        _isLoginMode = true; 
      });

      _emailController.clear();
      _passwordController.clear();

      _showSnackBar("Pendaftaran Berhasil! Silakan Login dengan akun baru Anda.", Colors.green);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Welcome & Small Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isLoginMode ? "Welcome" : "Create Account",
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryPink),
                    ),
                    Text(
                      _isLoginMode ? "Sign to your account" : "Register your new account here", 
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const Icon(Icons.local_fire_department, color: AppColors.primaryPink, size: 40),
              ],
            ),
            const SizedBox(height: 40),

            // Form Input Email
            const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Your email",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),

            // Form Input Password
            const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: _isPasswordObscured,
              decoration: InputDecoration(
                hintText: "Your Password",
                fillColor: Colors.grey[100],
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            
            if (_isLoginMode) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forget Password?", style: TextStyle(color: AppColors.primaryPink)),
                ),
              ),
              const SizedBox(height: 10),
            ] else ...[
              const SizedBox(height: 24),
            ],

            // Button Login / Sign Up yang Dinamis
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // Jika disabled, warna otomatis disesuaikan oleh Flutter (biasanya abu-abu)
                  backgroundColor: AppColors.primaryPink,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                // Jika _isButtonEnabled false, onPressed diisi null (tombol mati)
                onPressed: _isButtonEnabled ? _handleSubmit : null,
                child: Text(
                  _isLoginMode ? "Login" : "Sign Up", 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            
            // Switcher Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_isLoginMode ? "Don't Have an account..?" : "Already have an account?"),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLoginMode = !_isLoginMode;
                      _emailController.clear();
                      _passwordController.clear();
                    });
                  }, 
                  child: Text(
                    _isLoginMode ? "Sign Up" : "Login", 
                    style: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Or with", style: TextStyle(color: Colors.grey))),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),

            _buildSocialButton(Icons.g_mobiledata, _isLoginMode ? "Sign in with Google" : "Sign up with Google"),
            const SizedBox(height: 12),
            _buildSocialButton(Icons.apple, _isLoginMode ? "Sign in with Apple" : "Sign up with Apple"),
            const SizedBox(height: 12),
            _buildSocialButton(Icons.facebook, _isLoginMode ? "Sign in with Facebook" : "Sign up with Facebook"),
            
            const SizedBox(height: 40),
            const Center(child: Text("PT. Santai Digital", style: TextStyle(color: Colors.grey, fontSize: 12))),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      onPressed: () {},
      icon: Icon(icon, color: Colors.black87),
      label: Text(label, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
    );
  }
}