
import 'package:cp_api/screens/contests/usernames_input.dart';
import 'package:cp_api/screens/contests/upcoming_contest_screen.dart';
import 'package:cp_api/screens/settings/settings_screen.dart';
import 'package:cp_api/screens/user_profile/username_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Competitive Companion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: ListView(
          children: [
            OptionCard(
              icon: Icons.person,
              title: "Check User Profile",
              description: "View user profiles on various coding platforms.",
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UsernameInputScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.006),
            OptionCard(
              icon: Icons.code,
              title: "Check Contest Standings by Code",
              description: "Enter a contest code to view its standings.",
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UsernamesInputScreen(
                      contestMode: ContestMode.code,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.006),
            OptionCard(
              icon: Icons.new_releases,
              title: "View Latest Contest",
              description: "Discover the most recent coding contests.",
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UsernamesInputScreen(
                      contestMode: ContestMode.latest,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.006),
            OptionCard(
              icon: Icons.hourglass_bottom,
              title: "View Ongoing Contest",
              description: "See contests that are happening right now.",
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UsernamesInputScreen(
                      contestMode: ContestMode.ongoing,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.006),
            OptionCard(
              icon: Icons.calendar_today,
              title: "Check Upcoming Contests",
              description: "Stay informed about upcoming coding contests.",
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UpcomingContestScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.006),
            const Divider(),
            SizedBox(height: screenHeight * 0.006),
            OptionCard(
              icon: Icons.settings,
              title: "Settings",
              description: "Customize the app to your liking.",
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return const SettingsScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final double screenHeight;
  final double screenWidth;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.screenHeight,
    required this.screenWidth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            children: [
              IconButton.filledTonal(
                onPressed: () {},
                icon: Icon(
                  icon,
                  size: screenWidth * 0.072,
                ),
                padding: EdgeInsets.all(screenWidth * 0.024),
              ),
              SizedBox(width: screenWidth * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0048),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ContestMode {
  code,
  latest,
  ongoing,
}
