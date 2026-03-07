import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          IconButton(
            onPressed: controller.onLogoutPressed,
            icon: const Icon(Icons.logout, color: Color(0xFFf24e1e)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            Obx(() => Text(
              "Xin chào, ${controller.fullName.value}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 8),
            Obx(() => Text(
              "Tài khoản: ${controller.username.value}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            )),
          ],
        ),
      ),
    );
  }
}