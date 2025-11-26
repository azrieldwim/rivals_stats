import 'package:flutter/material.dart';
import 'package:rivals_stats/config/theme/app_colors.dart';

class LeaderboardHeader extends StatelessWidget {
  const LeaderboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 82,
            child: Text('Place', style: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              'Player Name',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              'Score',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
