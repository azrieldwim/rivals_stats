import 'package:get/get.dart';
import 'package:rivals_stats/modules/main/bindings/main_binding.dart';
import 'package:rivals_stats/modules/main/views/main_view.dart';
import 'app_routes.dart';
import '../../modules/profile/view/profile_view.dart';
import '../../modules/profile/bindings/profile_binding.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
