import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rivals_stats/data/services/marvel_service.dart';
import '../../../data/models/found_player_model.dart';

class HomeController extends GetxController {
  final MarvelService _playerService = Get.find<MarvelService>();
  final TextEditingController usernameController = TextEditingController();

  final isLoading = false.obs;

  final searchResults = <FoundPlayerModel>[].obs;

  Future<void> searchPlayer() async {
    final username = usernameController.text.trim();

    if (username.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchResults.clear();

    try {
      final FoundPlayerModel player = await _playerService.findPlayerByUsername(
        username,
      );
      searchResults.add(player);
    } on dio.DioException catch (e) {
      if (e.response?.statusCode != 404) {
        Get.snackbar('Error', 'Gagal mencari pemain: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }
}
