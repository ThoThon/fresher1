import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  final FocusNode taxFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final TextEditingController taxController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxBool autoValidate = false.obs;

  Future<bool> login() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final tax = taxController.text.trim();
      final user = usernameController.text.trim();
      final pass = passwordController.text.trim();
      await _authRepository.syncFromFirebase();
      final account = await _authRepository.login(tax, user, pass);

      if (account != null) {
        return true;
      } else {
        errorMessage.value = "Thông tin đăng nhập không hợp lệ";
        return false;
      }
    } catch (e) {
      debugPrint('Lỗi login : $e');
      errorMessage.value = "Đã có lỗi xảy ra. Vui lòng thử lại.";
    } finally {
      isLoading.value = false;
    }

    return false;
  }

  Future<void> onLoginPressed() async {
    autoValidate.value = true;
    if (formKey.currentState?.validate() ?? false) {
      final success = await login();

      if (success) {
        Get.offAllNamed('/home');
      } else {
        Get.defaultDialog(
          title: "Lỗi",
          middleText: errorMessage.value,
          backgroundColor: Colors.white,
          titleStyle: const TextStyle(color: Colors.black),
          middleTextStyle: const TextStyle(color: Colors.black),
          radius: 15,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFf24e1e),
              ),
              child: const Text("Đóng"),
            ),
          ],
        );
      }
    }
  }

  @override
  void onClose() {
    taxController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    taxFocus.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
