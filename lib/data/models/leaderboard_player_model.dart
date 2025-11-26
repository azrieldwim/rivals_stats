class LeaderboardPlayerModel {
  final String uid;
  final String name;
  final int score;
  final String playerIconPath;
  final RankDetails rankDetails;

  LeaderboardPlayerModel({
    required this.uid,
    required this.name,
    required this.score,
    required this.playerIconPath,
    required this.rankDetails,
  });

  factory LeaderboardPlayerModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? iconData =
        json['icon'] as Map<String, dynamic>?;

    return LeaderboardPlayerModel(
      uid: json['uid'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      score: json['score'] ?? 0,
      playerIconPath: iconData?['player_icon'] ?? '',
      rankDetails: RankDetails.fromJson(json['rank']),
    );
  }
}

class RankDetails {
  final String rankName;
  final String rankImage;
  final String rankColor;
  final String winRate;
  final int level;
  final double rankScore;
  final int winCount;
  final int battleCount;

  RankDetails({
    required this.rankName,
    required this.rankImage,
    required this.rankColor,
    required this.winRate,
    required this.level,
    required this.rankScore,
    required this.winCount,
    required this.battleCount,
  });

  factory RankDetails.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? rankObject =
        json['rank'] as Map<String, dynamic>?;

    return RankDetails(
      rankName: rankObject?['rank'] ?? 'N/A',
      rankImage: rankObject?['image'] ?? '',
      rankColor: rankObject?['color'] ?? '#FFFFFF',
      winRate: json['win_rate'] ?? '0%',
      level: json['level'] ?? 0,
      rankScore: (json['rank_score'] ?? 0.0).toDouble(),
      winCount: json['win_count'] ?? 0,
      battleCount: json['battle_count'] ?? 0,
    );
  }
}
