class PlayerProfileModel {
  final String uid;
  final String name;
  final PlayerDetail player;
  final OverallStats overallStats;
  final List<HeroStats> heroesRanked;

  PlayerProfileModel({
    required this.uid,
    required this.name,
    required this.player,
    required this.overallStats,
    required this.heroesRanked,
  });

  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) {
    return PlayerProfileModel(
      uid: json['uid'].toString(),
      name: json['name'] ?? '',
      player: PlayerDetail.fromJson(json['player'] ?? {}),
      overallStats: OverallStats.fromJson(json['overall_stats'] ?? {}),
      heroesRanked: (json['heroes_ranked'] as List?)
          ?.map((e) => HeroStats.fromJson(e))
          .toList() ?? [],
    );
  }
}

class PlayerDetail {
  final String level;
  final String rankName;
  final String rankImage;
  final String playerIcon;

  PlayerDetail({
    required this.level,
    required this.rankName,
    required this.rankImage,
    required this.playerIcon,
  });

  factory PlayerDetail.fromJson(Map<String, dynamic> json) {
    return PlayerDetail(
      level: json['level']?.toString() ?? '0',
      rankName: json['rank']?['rank'] ?? 'Unranked',
      rankImage: json['rank']?['image'] ?? '',
      playerIcon: json['icon']?['player_icon'] ?? '',
    );
  }
}

class OverallStats {
  final int totalMatches;
  final int totalWins;
  final RankedStats ranked;

  OverallStats({
    required this.totalMatches,
    required this.totalWins,
    required this.ranked,
  });

  factory OverallStats.fromJson(Map<String, dynamic> json) {
    return OverallStats(
      totalMatches: json['total_matches'] ?? 0,
      totalWins: json['total_wins'] ?? 0,
      ranked: RankedStats.fromJson(json['ranked'] ?? {}),
    );
  }
}

class RankedStats {
  final int totalMatches;
  final int totalWins;
  final int totalKills;
  final int totalDeaths;
  final int totalAssists;
  final String totalPlaytime;

  RankedStats({
    required this.totalMatches,
    required this.totalWins,
    required this.totalKills,
    required this.totalDeaths,
    required this.totalAssists,
    required this.totalPlaytime,
  });

  factory RankedStats.fromJson(Map<String, dynamic> json) {
    return RankedStats(
      totalMatches: json['total_matches'] ?? 0,
      totalWins: json['total_wins'] ?? 0,
      totalKills: json['total_kills'] ?? 0,
      totalDeaths: json['total_deaths'] ?? 0,
      totalAssists: json['total_assists'] ?? 0,
      totalPlaytime: json['total_time_played'] ?? '0h 0m',
    );
  }
}

class HeroStats {
  final int heroId;
  final String heroName;
  final String heroThumbnail;
  final int matches;
  final int wins;
  final double playTimeSeconds;
  
  double get winRate => matches > 0 ? (wins / matches) * 100 : 0.0;

  HeroStats({
    required this.heroId,
    required this.heroName,
    required this.heroThumbnail,
    required this.matches,
    required this.wins,
    required this.playTimeSeconds,
  });

  factory HeroStats.fromJson(Map<String, dynamic> json) {
    return HeroStats(
      heroId: json['hero_id'] ?? 0,
      heroName: json['hero_name'] ?? 'Unknown',
      heroThumbnail: json['hero_thumbnail'] ?? '',
      matches: json['matches'] ?? 0,
      wins: json['wins'] ?? 0,
      playTimeSeconds: (json['play_time'] ?? 0).toDouble(),
    );
  }
}