import 'package:linc_driver/tugas/utils/urls.dart';
import 'package:linc_driver/tugas/utils/widgets/widgets.dart';
import 'package:linc_driver/tugas/views/view_register.dart';
import 'package:linc_driver/tugas/views/view_home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewLogin extends StatefulWidget {
  const ViewLogin({super.key});

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isLoading = false;
  final Dio dio = Dio();

  Future<void> processLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      try {
        final response = await dio.post(
          "${baseURL}api/user/login",
          data: {
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
          },
        );

        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('access_token')) {
          // Jika login berhasil
          final SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString("access_token", responseData["access_token"]);
          await preferences.setString("token_type", responseData["token_type"]);
          await preferences.setString("name", responseData["data"]["name"]);
          await preferences.setString("email", responseData["data"]["email"]);

          Get.offAll(() => const ViewHome());

          // Tampilkan GetX Snackbar
          Get.snackbar(
            "Sukses",
            "Login berhasil!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.all(15),
            borderRadius: 8,
            duration: const Duration(seconds: 2),
          );
        } else {
          // Jika login gagal
          Get.snackbar(
            "Error",
            responseData["message"] ?? "Terjadi kesalahan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Color(0xFFB71C1C),
            colorText: Colors.white,
            margin: const EdgeInsets.all(15),
            borderRadius: 8,
            duration: const Duration(seconds: 2),
          );
        }
      } on DioException catch (e) {
        debugPrint("Dio Exception: ${e.message}");
        Get.snackbar(
          "Error",
          e.response?.data["message"] ?? "Terjadi kesalahan. Silakan coba lagi.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFFB71C1C),
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      } catch (e) {
        debugPrint("Exception: ${e.toString()}");
        Get.snackbar(
          "Error",
          "Terjadi kesalahan sistem. Silakan coba lagi.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFFB71C1C),
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Get.snackbar(
        "Error",
        "Harap periksa data yang dimasukkan!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Menambahkan gambar stiker login di atas form
              Image.asset(
                'assets/images/login.png',
                height: 300,  // Sesuaikan dengan ukuran gambar yang diinginkan
                width: 300,   // Sesuaikan dengan ukuran gambar yang diinginkan
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: myDecoration(
                        "Email",
                        const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap isi email";
                        } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
                          return "Format email tidak valid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: passwordController,
                      decoration: myDecoration(
                        "Password",
                        const Icon(Icons.lock),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: hidePassword
                              ? const Icon(Icons.visibility_off)  // Menampilkan ikon visibility_off saat password disembunyikan
                              : const Icon(Icons.visibility),      // Menampilkan ikon visibility saat password terlihat
                        ),
                      ),
                      obscureText: hidePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap isi password";
                        } else if (value.length < 8) {
                          return "Password minimal 8 karakter";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    if (isLoading)
                      const CircularProgressIndicator(),
                    if (!isLoading)
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: processLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFB71C1C),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Login"),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Belum punya akun?"),
            TextButton(
              onPressed: () {
                Get.off(() => const ViewRegister());
              },
              child: const Text(
                "Daftar",
                style: TextStyle(
                  color: Color(0xFFB71C1C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
