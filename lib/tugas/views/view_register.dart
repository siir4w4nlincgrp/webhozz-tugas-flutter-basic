import 'package:linc_driver/tugas/utils/urls.dart';
import 'package:linc_driver/tugas/utils/widgets/widgets.dart';
import 'package:linc_driver/tugas/views/view_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewRegister extends StatefulWidget {
  const ViewRegister({super.key});

  @override
  State<ViewRegister> createState() => _ViewRegisterState();
}

class _ViewRegisterState extends State<ViewRegister> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  final dio = Dio();
  bool isLoading = false;
  bool hidePassword = true;
  bool hidePasswordConfirmation = true;

  void processRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      try {
        var response = await dio.post(
          "${baseURL}api/user/register",
          data: {
            "name": _namaController.text.trim(),
            "email": _emailController.text.trim(),
            "password": _passwordController.text.trim(),
          },
        );
        debugPrint(response.toString());

        Get.snackbar(
          "Sukses",
          "Registrasi berhasil!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );

        Future.delayed(const Duration(seconds: 2), () {
          Get.off(() => const ViewLogin());
        });
      } on DioException catch (e) {
        debugPrint("Dio Exception: ${e.message}");
        Get.snackbar(
          "Error",
          e.response?.data["message"] ?? "Terjadi kesalahan. Silakan coba lagi.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
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
          backgroundColor: Colors.red,
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
        "Harap periksa data yang diMasukan!",
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.off(() => const ViewLogin());
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "REGISTER",
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
                      controller: _namaController,
                      decoration: myDecoration(
                        "Masukan Nama",
                        const Icon(Icons.account_circle_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap Masukan Nama";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      decoration: myDecoration(
                        "Masukan Email",
                        const Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap Masukan Email";
                        } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
                          return "Format email tidak valid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _nohpController,
                      decoration: myDecoration(
                        "Masukan No Hp",
                        const Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap Masukan Nomor Hp";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      decoration: myDecoration(
                        "Masukan Password",
                        const Icon(Icons.lock),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: hidePassword
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: hidePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap Masukan Password";
                        } else if (value.length < 8) {
                          return "Password minimal 8 karakter";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordConfirmationController,
                      decoration: myDecoration(
                        "Masukan Konfirmasi Password",
                        const Icon(Icons.lock_outline),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePasswordConfirmation = !hidePasswordConfirmation;
                            });
                          },
                          icon: hidePasswordConfirmation
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: hidePasswordConfirmation,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap Masukan Konfirmasi Password";
                        } else if (value != _passwordController.text) {
                          return "Konfirmasi Password tidak cocok";
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
                          onPressed: processRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Register"),
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
            const Text("Sudah Punya Akun ?"),
            TextButton(
              onPressed: () {
                Get.off(() => const ViewLogin());
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}