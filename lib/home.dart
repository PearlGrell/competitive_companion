
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hgv2/api/api.dart';
import 'package:hgv2/models/codechef_model.dart';
import 'package:hgv2/models/codeforces_model.dart';
import 'package:hgv2/models/gfg_model.dart';
import 'package:hgv2/models/leetcode_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(MediaQuery
              .of(context)
              .size
              .width * 0.048),
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
                              Radius.circular(MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.024),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.024),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.24,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.14,
                      child: FilledButton(
                        onPressed: () {
                          _handleSubmit(emailController.text);
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_hasValidData(codeChefModel))
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
                if (_hasValidData(codeforcesModel))
                  _buildProfileCard(
                    title: "Codeforces Profile",
                    details: [
                      "Name: ${codeforcesModel.name}",
                      "Rating: ${codeforcesModel.rating}",
                      "Max Rating: ${codeforcesModel.maxRating}",
                      "Rank: ${codeforcesModel.rank}",
                      "Max Rank: ${codeforcesModel.maxRank}",
                      "Contribution: ${codeforcesModel.contribution}",
                    ],
                  ),
                if (_hasValidData(leetCodeModel))
                  _buildProfileCard(
                    title: "LeetCode Profile",
                    details: [
                      "Username: ${leetCodeModel.username}",
                      "Real Name: ${leetCodeModel.name}",
                      "Rating: ${leetCodeModel.ranking}",
                      "Solved Problems: ${leetCodeModel.solvedProblem}",
                      "Badges: ${leetCodeModel.badges}",
                      "Reputation: ${leetCodeModel.reputation}",
                    ],
                  ),
                if (_hasValidData(geeksForGeeksModel))
                  _buildProfileCard(
                    title: "GeeksForGeeks Profile",
                    details: [
                      "Name: ${geeksForGeeksModel.name}",
                      "Institute Rank: ${geeksForGeeksModel.instituteRank}",
                      "Current Streak: ${geeksForGeeksModel.currentStreak}",
                      "Max Streak: ${geeksForGeeksModel.maxStreak}",
                      "Institution: ${geeksForGeeksModel.institution}",
                      "Coding Score: ${geeksForGeeksModel.codingScore}",
                      "Total Problems Solved: ${geeksForGeeksModel
                          .totalProblemsSolved}",
                    ],
                    solvedStats: geeksForGeeksModel.solvedStats,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleSubmit(String handle) async {
    try {
      List<Map<String, dynamic>> responses = await API.getUserInfo(handle);

      for (var response in responses) {
        setState(() {
          if (response['platform'] == 'codeforces') {
            codeforcesModel = response['data'] as CodeforcesModel;
          } else if (response['platform'] == 'codechef') {
            codeChefModel = response['data'] as CodeChefModel;
          } else if (response['platform'] == 'leetcode') {
            leetCodeModel = response['data'] as LeetCodeModel;
          } else if (response['platform'] == 'geeksforgeeks') {
            geeksForGeeksModel = response['data'] as GeeksForGeeksModel;
          }
        });
      }
    } catch (error) {
      log('Error: $error');
    }
  }


  Widget _buildProfileCard({
    required String title,
    required List<String> details,
    Map<String, dynamic>? solvedStats,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...details.map((detail) => Text(detail)),
            if (solvedStats != null && solvedStats.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                "Solved Stats:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Table(
                border: TableBorder.all(color: Colors.grey, width: 0.5),
                children: solvedStats.entries.map((entry) {
                  return TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        entry.key.capitalize(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        entry.value.toString(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _hasValidData(dynamic model) {
    if (model is CodeChefModel) {
      return model.name != 'N/A' && model.name != null;
    } else if (model is CodeforcesModel) {
      return model.name != 'N/A' && model.name != null;
    } else if (model is LeetCodeModel) {
      return model.name != 'N/A' && model.name != null;
    } else if (model is GeeksForGeeksModel) {
      return model.profilePhoto != 'N/A' && model.profilePhoto != null;
    }
    return false;
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}