import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';
import 'widgets/footer_button.dart';
import 'widgets/input_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: _buildBodyPage(),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconLogo(),
        const SizedBox(height: 24),
        _buildTaxCode(),
        const SizedBox(height: 24),
        _buildUserName(),
        const SizedBox(height: 24),
        _buildPassword(),
        const SizedBox(height: 24),
        _buttonLogin().paddingOnly(bottom: 180),
        _buildBottom().paddingOnly(bottom: 24),
      ],
    );
  }

  Widget _buildIconLogo() {
    return Container(
      padding: const EdgeInsets.only(top: 70, left: 16),
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 180,
        height: 50,
      ),
    );
  }

  Widget _buildTaxCode() {
    return Obx(
      () => InputField(
        label: "Mã số thuế",
        controller: controller.taxController,
        focusNode: controller.taxFocus,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) =>
            FocusScope.of(Get.context!).requestFocus(controller.usernameFocus),
        autoValidateMode: controller.autoValidate.value
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]')),
        ],
        hintText: 'Mã số thuế',
        clearIconAsset: 'assets/icons/blank.svg',
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Vui lòng nhập CCCD 12 số hoặc MST hợp lệ.';
          }
          final mstRegex = RegExp(r'^(\d{12}|\d{10}-\d{3})$');
          if (!mstRegex.hasMatch(value.trim())) {
            return 'Vui lòng nhập CCCD 12 số hoặc MST hợp lệ.';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildUserName() {
    return Obx(
      () => InputField(
          label: "Tài khoản",
          controller: controller.usernameController,
          focusNode: controller.usernameFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(Get.context!)
              .requestFocus(controller.passwordFocus),
          autoValidateMode: controller.autoValidate.value
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          hintText: 'Tài khoản',
          clearIconAsset: 'assets/icons/blank.svg',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tài khoản không được để trống';
            }
            return null;
          }),
    );
  }

  Widget _buildPassword() {
    return Obx(
      () => InputField(
        label: "Mật khẩu",
        controller: controller.passwordController,
        focusNode: controller.passwordFocus,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => controller.onLoginPressed(),
        autoValidateMode: controller.autoValidate.value
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        hintText: 'Mật khẩu',
        showPassword: true,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Mật khẩu phải từ 6-50 ký tự.';
          }
          if (value.length < 6 || value.length > 50) {
            return 'Mật khẩu phải từ 6-50 ký tự.';
          }
          return null;
        },
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: 400,
        height: 60,
        child: Obx(
          () => ElevatedButton(
            onPressed:
                controller.isLoading.value ? null : controller.onLoginPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFf24e1e),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Color(0xFFf24e1e),
                    ),
                  )
                : const Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FooterButton(
            svgAsset: 'assets/icons/headphone.svg',
            label: 'Trợ giúp',
            onTap: () => debugPrint('Trợ giúp được bấm'),
          ),
          FooterButton(
            svgAsset: 'assets/icons/facebook.svg',
            label: 'Group',
            onTap: () => debugPrint('Group được bấm'),
          ),
          FooterButton(
            svgAsset: 'assets/icons/search.svg',
            label: 'Tra cứu',
            onTap: () => debugPrint('Tra cứu được bấm'),
          ),
        ],
      ),
    );
  }
}
