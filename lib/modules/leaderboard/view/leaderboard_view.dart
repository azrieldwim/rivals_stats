import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivals_stats/config/theme/app_colors.dart';
import 'package:rivals_stats/modules/leaderboard/controller/leaderboard_controller.dart';
import 'package:rivals_stats/modules/leaderboard/widgets/leaderboard_card.dart';
import 'package:rivals_stats/modules/leaderboard/widgets/leaderboard_header.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.leaderboardList.isEmpty) {
          return const Center(child: Text('Data Leaderboard kosong.'));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Text(
                textAlign: TextAlign.center,
                'Global Player Rankings Based on Rank Score This Season',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const LeaderboardHeader(),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                itemCount: controller.leaderboardList.length,
                itemBuilder: (context, index) {
                  final player = controller.leaderboardList[index];
                  return LeaderboardCard(player: player, rank: index + 1);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
