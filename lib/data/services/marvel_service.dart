import 'package:dio/dio.dart' as dio;
import 'package:rivals_stats/data/models/found_player_model.dart';
import 'package:rivals_stats/data/models/leaderboard_player_model.dart';
import 'package:rivals_stats/data/models/player_profile_model.dart';
import 'package:rivals_stats/data/services/api_config.dart';
import 'package:rivals_stats/data/services/api_service.dart';

class MarvelService {
  final ApiService _api = ApiService();

  Future<List<LeaderboardPlayerModel>> fetchLeaderboard() async {
    final endpoint = ApiConfig.leaderboard;

    final response = await _api.get(endpoint);
    if (response.data['players'] is List) {
      return (response.data['players'] as List)
          .map((json) => LeaderboardPlayerModel.fromJson(json))
          .toList();
    }
    return [];
  }

  Future<FoundPlayerModel> findPlayerByUsername(String query) async {
    final endpoint = ApiConfig.findPlayer(query);

    try {
      final response = await _api.get(endpoint);
      return FoundPlayerModel.fromJson(response.data);
    } on dio.DioException {
      rethrow;
    }
  }

  Future<PlayerProfileModel> fetchPlayerProfile(String usernameOrUid) async {
    final endpoint = ApiConfig.findUsername(usernameOrUid);

    final response = await _api.get(endpoint);
    return PlayerProfileModel.fromJson(response.data);
  }
}
