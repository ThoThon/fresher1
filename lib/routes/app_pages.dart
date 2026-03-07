import 'package:get/get.dart';
import '../home/binding/home_binding.dart';
import '../home/ui/home_screen.dart';
import '../login/binding/login_binding.dart';
import '../login/ui/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
