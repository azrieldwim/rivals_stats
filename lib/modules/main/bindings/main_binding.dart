import 'package:get/get.dart';
import 'package:rivals_stats/data/services/api_service.dart';
import 'package:rivals_stats/data/services/marvel_service.dart';
import 'package:rivals_stats/modules/home/controller/home_controller.dart';
import 'package:rivals_stats/modules/leaderboard/controller/leaderboard_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());

    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<MarvelService>(MarvelService(), permanent: true);

    Get.put<LeaderboardController>(LeaderboardController(), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
