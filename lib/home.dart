import 'package:flutter/material.dart';
import 'package:cp_api/api/api.dart';
import 'package:cp_api/contest_screen.dart';
import 'package:cp_api/models/codechef_model.dart';
import 'package:cp_api/models/codeforces_model.dart';
import 'package:cp_api/models/gfg_model.dart';
import 'package:cp_api/models/leetcode_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailController = TextEditingController();
  CodeforcesModel codeforcesModel = CodeforcesModel();
  CodeChefModel codeChefModel = CodeChefModel();
  LeetCodeModel leetCodeModel = LeetCodeModel();
  GeeksForGeeksModel geeksForGeeksModel = GeeksForGeeksModel();

  bool isLoading = false; // Tracks the loading state
  String? errorMessage; // Stores error messages

  @override
  Widget build(BuildContext context) {
    bool hasData = codeChefModel.name != null ||
        codeforcesModel.name != null ||
        leetCodeModel.username != null ||
        geeksForGeeksModel.name != null;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.048),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  MediaQuery.of(context).size.width * 0.024),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.024),
                    FilledButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              _handleSubmit(emailController.text);
                            },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (isLoading) const Center(child: CircularProgressIndicator()),
                // Show loader
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
                          onPressed: isLoading
                              ? null
                              : () => _handleSubmit(emailController.text),
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                if (!isLoading && errorMessage == null) ...[
                  if (hasData)
                    Column(
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
                      ],
                    )
                  else
                    const Center(
                      child: Text('No data available'),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContestScreen(),
            ),
          );
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }

  Future<void> _handleSubmit(String handle) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final Map<String, dynamic> data = await API.getUserInfo(handle);
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
