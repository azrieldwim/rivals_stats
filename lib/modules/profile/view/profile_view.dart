import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivals_stats/config/theme/app_colors.dart';
import 'package:rivals_stats/data/services/api_config.dart';
import '../../../data/models/player_profile_model.dart';
import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  final String iconBaseUrl = ApiConfig.iconBaseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Player Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;

        if (profile == null) {
          return const Center(child: Text("Data profil tidak ditemukan."));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(context, profile),
              const SizedBox(height: 20),
              Text(
                'Ranked Stats',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              _buildStatsGrid(context, profile),
              const SizedBox(height: 10),
              Text('Top Heroes', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              _buildHeroesList(context, profile),
              const SizedBox(height: 10),
              Text(
                'Recent Matches',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              _buildMatchHistory(context, profile),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader(BuildContext context, PlayerProfileModel profile) {
    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.cardBackgroundPurple,
              backgroundImage: NetworkImage(
                '$iconBaseUrl${profile.player.playerIcon}',
              ),
              onBackgroundImageError: (_, __) => const Icon(Icons.person),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.player.rankName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.amber,
                    ),
                  ),
                  Text(
                    profile.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Level ${profile.player.level}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (profile.player.rankImage.isNotEmpty)
              Image.network(
                '$iconBaseUrl${profile.player.rankImage}',
                width: 60,
                height: 60,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, PlayerProfileModel profile) {
    final stats = profile.overallStats.ranked;

    final double winRate =
        stats.totalMatches > 0
            ? (stats.totalWins / stats.totalMatches) * 100
            : 0.0;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _buildStatItem('Matches', '${stats.totalMatches}'),
        _buildStatItem('Wins', '${stats.totalWins}'),
        _buildStatItem(
          'Win Rate',
          '${winRate.toStringAsFixed(1)}%',
          isHighlight: true,
        ),
        _buildStatItem('Play Time', stats.totalPlaytime),
      ],
    );
  }

  Widget _buildStatItem(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: isHighlight ? Border.all(color: AppColors.primary) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isHighlight ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroesList(BuildContext context, PlayerProfileModel profile) {
    if (profile.heroesRanked.isEmpty) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: Text(
          "Belum ada data hero ranked.",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      );
    }

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: profile.heroesRanked.length,
        itemBuilder: (context, index) {
          final hero = profile.heroesRanked[index];
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        '$iconBaseUrl${hero.heroThumbnail}',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              color: AppColors.cardBackgroundPurple,
                              height: 80,
                              width: 80,
                            ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${hero.winRate.toStringAsFixed(0)}% WR',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontSize: 10, color: AppColors.green),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  hero.heroName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 12),
                ),
                Text(
                  '${hero.matches} Matches',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMatchHistory(BuildContext context, PlayerProfileModel profile) {
    final matches = profile.matchHistory.take(10).toList();

    if (matches.isEmpty) {
      return Text(
        "Tidak ada Match History.",
        style: Theme.of(context).textTheme.titleSmall,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        final performance = match.playerPerformance;
        final bool isWin = performance.isWin;
        final Color sideColor = isWin ? AppColors.green : AppColors.red2;
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          color: AppColors.cardBackground,
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 4, height: 40, color: sideColor),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '$iconBaseUrl${performance.heroType}',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => Container(
                          width: 40,
                          height: 40,
                          color: AppColors.cardBackgroundPurple,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 16,
                          ),
                        ),
                  ),
                ),
              ],
            ),
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      performance.heroName,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      isWin ? "VICTORY" : "DEFEAT",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: sideColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${performance.kills} / ${performance.deaths} / ${performance.assists}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: sideColor,
                  ),
                ),
                Text(
                  'Duration: ${controller.formatMatchDuration(match.duration)}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
