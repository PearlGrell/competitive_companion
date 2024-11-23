import 'package:flutter/material.dart';
import 'api/api.dart';

class UpcomingContestScreen extends StatefulWidget {
  const UpcomingContestScreen({super.key});

  @override
  State<UpcomingContestScreen> createState() => _UpcomingContestScreenState();
}

class _UpcomingContestScreenState extends State<UpcomingContestScreen> {
  List<Map<String, dynamic>> contestsCodeforces = [];
  bool isLoading = true; 
  String? errorMessage; 

  @override
  void initState() {
    super.initState();
    _fetchUpcomingContests("codeforces");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            contestsCodeforces = [];
            errorMessage = null;
            isLoading = true;
          });
          _fetchUpcomingContests("codeforces");
        },
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            const Text(
              "Codeforces Contests",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator()) 
                  : errorMessage != null
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          errorMessage = null;
                          isLoading = true;
                        });
                        _fetchUpcomingContests("codeforces");
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              )
                  : contestsCodeforces.isEmpty
                  ? const Center(
                child: Text(
                  "No upcoming contests found.",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: contestsCodeforces.length,
                itemBuilder: (context, index) {
                  String startTime =
                  contestsCodeforces[index]['startTime'];
                  String formattedTime = startTime;

                  return Card(
                    child: ListTile(
                      title: Text(
                          contestsCodeforces[index]['contestName']),
                      subtitle: Text('Starts at: $formattedTime'),
                      trailing: Text(
                          'Contest ID: ${contestsCodeforces[index]['contestId']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchUpcomingContests(String platform) async {
    try {
      List<Map<String, dynamic>> fetchedContests =
      await API.getUpcomingContests(platform);
      setState(() {
        contestsCodeforces = fetchedContests;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }
}
