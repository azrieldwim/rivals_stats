class PlayerProfileModel {
  final String uid;
  final String name;
  final PlayerDetail player;
  final OverallStats overallStats;
  final List<HeroStats> heroesRanked;
  final List<MatchHistory> matchHistory;

  PlayerProfileModel({
    required this.uid,
    required this.name,
    required this.player,
    required this.overallStats,
    required this.heroesRanked,
    required this.matchHistory,
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
          matchHistory: (json['match_history'] as List?)
          ?.map((e) => MatchHistory.fromJson(e))
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

class MatchHistory {
  final String matchUid;
  final double duration;
  final int season;
  final String mapThumbnail;
  final PlayerPerformance playerPerformance;

  MatchHistory({
    required this.matchUid,
    required this.duration,
    required this.season,
    required this.mapThumbnail,
    required this.playerPerformance,
  });

  factory MatchHistory.fromJson(Map<String, dynamic> json) {
    return MatchHistory(
      matchUid: json['match_uid'] ?? '',
      duration: (json['duration'] ?? 0.0).toDouble(),
      season: json['season'] ?? 0,
      mapThumbnail: json['map_thumbnail'] ?? '',
      playerPerformance: PlayerPerformance.fromJson(json['player_performance'] ?? {}),
    );
  }
}

class PlayerPerformance {
  final String heroName;
  final String heroType;
  final int kills;
  final int deaths;
  final int assists;
  final bool isWin;
  final double scoreChange;

  PlayerPerformance({
    required this.heroName,
    required this.heroType,
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.isWin,
    required this.scoreChange,
  });

  factory PlayerPerformance.fromJson(Map<String, dynamic> json) {
    final bool isWin = json['is_win']?['is_win'] ?? false;
    
    return PlayerPerformance(
      heroName: json['hero_name'] ?? 'N/A',
      heroType: json['hero_type'] ?? '',
      kills: json['kills'] ?? 0,
      deaths: json['deaths'] ?? 0,
      assists: json['assists'] ?? 0,
      isWin: isWin,
      scoreChange: (json['score_change'] ?? 0.0).toDouble(), 
    );
  }
}