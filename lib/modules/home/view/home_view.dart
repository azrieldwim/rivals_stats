import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivals_stats/config/routes/app_routes.dart';
import 'package:rivals_stats/config/theme/app_colors.dart';
import 'package:rivals_stats/modules/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                'assets/images/marvelRivals_logo.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 10),
              Text(
                'MARVEL RIVALS STATS',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Check Detailed Marvel Rivals Stats and Leaderboards',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Enter Username or UID',
                  labelStyle: TextStyle(color: AppColors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: AppColors.cardBackground,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: AppColors.textSecondary),
                  ),
                ),
                onSubmitted: (_) => controller.searchPlayer(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.searchPlayer();
                  },
                  child: Text(
                    'Search Player',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.isTrue) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.searchResults.isNotEmpty) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Result:',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.searchResults.length,
                            itemBuilder: (context, index) {
                              final player = controller.searchResults[index];
                              return Card(
                                color: AppColors.cardBackground,
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor:
                                        AppColors.cardBackgroundPurple,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        player.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontSize: 20),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'UID: ${player.uid}',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ),
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.profile,
                                      arguments: player.uid,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
