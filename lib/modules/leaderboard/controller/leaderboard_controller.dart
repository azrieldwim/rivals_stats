import 'package:get/get.dart';
import '../../../data/models/leaderboard_player_model.dart';
import '../../../data/services/marvel_service.dart';

class LeaderboardController extends GetxController {
  final MarvelService _profileService = Get.find<MarvelService>();

  final leaderboardList = <LeaderboardPlayerModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaderboardData();
  }

  Future<void> fetchLeaderboardData() async {
    try {
      isLoading(true);
      final list = await _profileService.fetchLeaderboard();
      leaderboardList.assignAll(list);
    } catch (e) {
      print('Error fetching leaderboard data: $e');
      Get.snackbar('Error', 'Gagal memuat Leaderboard.');
    } finally {
      isLoading(false);
    }
  }
}
