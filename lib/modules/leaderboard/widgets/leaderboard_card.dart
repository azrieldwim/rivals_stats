import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivals_stats/config/routes/app_routes.dart';
import 'package:rivals_stats/config/theme/app_colors.dart';
import 'package:rivals_stats/data/services/api_config.dart';
import '../../../data/models/leaderboard_player_model.dart';

class LeaderboardCard extends StatelessWidget {
  final LeaderboardPlayerModel player;
  final int rank;

  const LeaderboardCard({super.key, required this.player, required this.rank});

  @override
  Widget build(BuildContext context) {
    final String iconBaseUrl = ApiConfig.iconBaseUrl;

    return Card(
      color: _getCardColorByRank(rank),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () {
          Get.toNamed(Routes.profile, arguments: player.uid);
        },
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              alignment: Alignment.center,
              child: _buildRankIndicator(context, rank),
            ),
            const SizedBox(width: 14),
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 20,
              child: ClipOval(
                child: Image.network(
                  '$iconBaseUrl${player.playerIconPath}',
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),

        title: Row(
          children: [
            Image.network(
              '$iconBaseUrl${player.rankDetails.rankImage}',
              width: 32,
              height: 32,
            ),
            SizedBox(width: 8),
            Text(player.name, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        trailing: Text(
          player.rankDetails.rankScore.toInt().toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}

Widget _buildRankIndicator(BuildContext context, int rank) {
  if (rank == 1) {
    return Image.asset('assets/images/rank_1.png');
  } else {
    return Text(
      '$rank',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
    );
  }
}

Color _getCardColorByRank(int rank) {
  switch (rank) {
    case 1:
      return AppColors.gold.withOpacity(0.2);
    case 2:
      return AppColors.cardBackground;
    case 3:
      return AppColors.red.withOpacity(0.15);
    default:
      if (rank % 2 == 0) {
        return AppColors.cardBackground;
      } else {
        return AppColors.cardBackgroundPurple;
      }
  }
}
