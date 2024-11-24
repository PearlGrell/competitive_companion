import 'package:flutter/material.dart';

class CodeforcesAPIDocs extends StatelessWidget {
  const CodeforcesAPIDocs({super.key});

  Widget _buildApiDescriptionCard(String title, String description, String example, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(description),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                text: "Example: ",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: example,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Codeforces API Documentation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Codeforces API Documentation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "The Codeforces API provides several endpoints to fetch user information, contest standings, and contest details.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              // Fetch User Data
              _buildApiDescriptionCard(
                "1. Fetch User Data",
                "This endpoint fetches user information for a given Codeforces username. You can retrieve the user's rank, rating, contributions, etc.",
                "/user.info?handles=your_username",
                context,
              ),
              _buildApiDescriptionCard(
                "2. Fetch Contest Standings",
                "This endpoint fetches the standings for a specific contest. You need to pass the contest ID and the list of usernames.",
                "/contest.standings?contestId=contest_id&handles=usernames",
                context,
              ),
              _buildApiDescriptionCard(
                "3. Fetch Latest Finished Contest Standings",
                "This endpoint fetches the standings for the most recent finished contest for the given usernames.",
                "/contest.list?gym=false",
                context,
              ),
              _buildApiDescriptionCard(
                "4. Fetch Ongoing Contest Standings",
                "This endpoint fetches the standings for an ongoing contest. You need to provide the usernames.",
                "/contest.list?gym=false",
                context,
              ),
              _buildApiDescriptionCard(
                "5. Fetch Upcoming Contest Details",
                "This endpoint fetches the details for upcoming contests such as the contest name and start time.",
                "/contest.list?gym=false",
                context,
              ),

              const SizedBox(height: 24),
              Text(
                "Example API Calls:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildApiDescriptionCard(
                "Example: Fetch User Data",
                "Fetch details about a user by calling the endpoint with their handle.\nExample: /user.info?handles=div1coder",
                "GET /user.info?handles=div1coder",
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
