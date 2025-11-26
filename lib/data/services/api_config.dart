import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String apiKey = dotenv.env['API_KEY'] ?? '';

  static const baseUrl = "https://marvelrivalsapi.com";

  static const String iconBaseUrl = 'https://marvelrivalsapi.com/rivals';

  static const String leaderboard = "/api/v2/players/leaderboard";

  static String findUsername(String usernameOrUid) =>
      "/api/v1/player/$usernameOrUid";
  static String findPlayer(String query) => "/api/v1/find-player/$query";
}
