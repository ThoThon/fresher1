import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/storage_service.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();
  
  final RxString username = ''.obs;
  final RxString fullName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    username.value = _storage.getSession() ?? 'Unknown';
    final acc = _storage.getAccount(username.value);
    fullName.value = acc?.fullName ?? 'Người dùng';
  }

  void onLogoutPressed() {
    Get.defaultDialog(
      title: "Xác nhận",
      middleText: "Bạn có chắc chắn muốn đăng xuất không?",
      textConfirm: "OK",
      textCancel: "Hủy",
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFf24e1e),
      onConfirm: () async {
        await _storage.clearSession();
        Get.offAllNamed(Routes.login); 
      },
    );
  }
}