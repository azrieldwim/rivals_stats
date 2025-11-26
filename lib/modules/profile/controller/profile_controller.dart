import 'package:get/get.dart';
import 'package:rivals_stats/config/theme/app_colors.dart';
import 'package:rivals_stats/data/services/marvel_service.dart';
import '../../../data/models/player_profile_model.dart';

class ProfileController extends GetxController {
  final MarvelService _playerService = Get.find<MarvelService>();

  final String userId = Get.arguments as String;

  final isLoading = true.obs;
  final profile = Rx<PlayerProfileModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading(true);
      final data = await _playerService.fetchPlayerProfile(userId);
      profile.value = data;
    } catch (e) {
      String message = '';
      if (e.toString().contains('403')) {
        message = 'Akses ditolak (403). This players profile is private.';
      }

      Get.snackbar('Error', message, backgroundColor: AppColors.red2);
    } finally {
      isLoading(false);
    }
  }

  String formatMatchDuration(double seconds) {
    final int minutes = (seconds / 60).truncate();
    final int remainingSeconds = (seconds % 60).truncate();
    return '${minutes}m ${remainingSeconds}s';
  }
}
