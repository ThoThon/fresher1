import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/services/encryption_service.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EncryptionService());
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut<LoginController>(
        () => LoginController(Get.find<AuthRepository>()));
  }
}
