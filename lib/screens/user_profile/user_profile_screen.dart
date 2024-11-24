import 'package:flutter/material.dart';
import 'package:cp_api/provider/api.dart';
import 'package:cp_api/models/codechef_model.dart';
import 'package:cp_api/models/codeforces_model.dart';
import 'package:cp_api/models/gfg_model.dart';
import 'package:cp_api/models/leetcode_model.dart';

class UserProfileScreen extends StatefulWidget {
  final bool defaultMode;
  final String? defaultUsername;
  final String? codeforcesUsername;
  final String? codechefUsername;
  final String? leetcodeUsername;
  final String? gfgUsername;

  const UserProfileScreen.defaultUsername(
      {super.key, required this.defaultUsername})
      : defaultMode = true,
        codeforcesUsername = null,
        codechefUsername = null,
        leetcodeUsername = null,
        gfgUsername = null;

  const UserProfileScreen.individualUsername({
    super.key,
    required this.codeforcesUsername,
    required this.codechefUsername,
    required this.leetcodeUsername,
    required this.gfgUsername,
  })  : defaultMode = false,
        defaultUsername = null;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  CodeforcesModel codeforcesModel = CodeforcesModel();
  CodeChefModel codeChefModel = CodeChefModel();
  LeetCodeModel leetCodeModel = LeetCodeModel();
  GeeksForGeeksModel geeksForGeeksModel = GeeksForGeeksModel();

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    _req();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    bool hasData = codeChefModel.name != null ||
        codeforcesModel.name != null ||
        leetCodeModel.username != null ||
        geeksForGeeksModel.name != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : () => _req(),
        child: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: isLoading ? null : () => _req(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            if (!isLoading && errorMessage == null) ...[
              if (hasData)
                Expanded(
                  child: ListView(
                    children: [
                      if (codeChefModel.name != null)
                        _buildProfileCard(
                          title: "CodeChef Profile",
                          details: [
                            "Name: ${codeChefModel.name}",
                            "Rating: ${codeChefModel.rating}",
                            "Max Rating: ${codeChefModel.maxRating}",
                            "Global Rank: ${codeChefModel.globalRank}",
                            "Country Rank: ${codeChefModel.countryRank}",
                          ],
                        ),
                      if (codeforcesModel.name != null)
                        _buildProfileCard(
                          title: "Codeforces Profile",
                          details: [
                            "Username: ${codeforcesModel.handle}",
                            "Name: ${codeforcesModel.name}",
                            "Rating: ${codeforcesModel.rating}",
                            "Max Rating: ${codeforcesModel.maxRating}",
                            "Rank: ${codeforcesModel.rank}",
                            "Max Rank: ${codeforcesModel.maxRank}",
                            "Contribution: ${codeforcesModel.contribution}",
                          ],
                        ),
                      if (leetCodeModel.username != null)
                        _buildProfileCard(
                          title: "LeetCode Profile",
                          details: [
                            "Username: ${leetCodeModel.username}",
                            "Real Name: ${leetCodeModel.realName}",
                            "Rating: ${leetCodeModel.country}",
                            "Solved Problems: ${leetCodeModel.solvedProblems}",
                            "Badges: ${leetCodeModel.school}",
                            "Reputation: ${leetCodeModel.company}",
                          ],
                        ),
                      if (geeksForGeeksModel.name != null)
                        _buildProfileCard(
                          title: "GeeksForGeeks Profile",
                          details: [
                            "Name: ${geeksForGeeksModel.name}",
                            "Institute Rank: ${geeksForGeeksModel.instituteRank}",
                            "Current Streak: ${geeksForGeeksModel.currentStreak}",
                            "Max Streak: ${geeksForGeeksModel.maxStreak}",
                            "Institution: ${geeksForGeeksModel.institution}",
                            "Coding Score: ${geeksForGeeksModel.codingScore}",
                            "Total Problems Solved: ${geeksForGeeksModel.totalProblemsSolved}",
                          ],
                          solvedStats: geeksForGeeksModel.solvedStats,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "*Note: If the user has not registered on a platform, the card will not show.",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text('No data available'),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }


  Future<void> _req() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    if (widget.defaultMode) {
      try {
        final Map<String, dynamic> data =
            await API.getUserInfo(widget.defaultUsername!);
        setState(() {
          codeforcesModel = data['codeforces'];
          codeChefModel = data['codechef'];
          leetCodeModel = data['leetcode'];
          geeksForGeeksModel = data['geeksforgeeks'];
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to fetch data: $e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch data: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      try {
        final Map<String, dynamic> data = await API.getUserInfoByPlatform(
          widget.codeforcesUsername!,
          widget.codechefUsername!,
          widget.gfgUsername!,
          widget.leetcodeUsername!,
        );
        setState(() {
          codeforcesModel = data['codeforces'];
          codeChefModel = data['codechef'];
          leetCodeModel = data['leetcode'];
          geeksForGeeksModel = data['geeksforgeeks'];
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to fetch data: $e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch data: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _buildProfileCard({
    required String title,
    required List<String> details,
    SolvedStats? solvedStats,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...details.map((detail) => Text(detail)),
              if (solvedStats != null) ...[
                const SizedBox(height: 8),
                const Text(
                  "Solved Stats",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Easy: ${solvedStats.easy}"),
                Text("Medium: ${solvedStats.medium}"),
                Text("Hard: ${solvedStats.hard}"),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
