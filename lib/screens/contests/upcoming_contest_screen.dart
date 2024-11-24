import 'package:flutter/material.dart';
import '../../provider/api.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Contests"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshContests,
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Codeforces Contests",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                    ? _buildErrorState()
                    : contestsCodeforces.isEmpty
                    ? _buildEmptyState()
                    : _buildContestList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage ?? "An error occurred.",
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _refreshContests,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "No upcoming contests found.",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContestList() {
    return ListView.builder(
      itemCount: contestsCodeforces.length,
      itemBuilder: (context, index) {
        final contest = contestsCodeforces[index];
        return ContestCard(
          name: contest['contestName'],
          startTime: contest['startTime'], // Already formatted
          contestId: contest['contestId'].toString(),
        );
      },
    );
  }

  void _refreshContests() {
    setState(() {
      contestsCodeforces = [];
      errorMessage = null;
      isLoading = true;
    });
    _fetchUpcomingContests("codeforces");
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

class ContestCard extends StatelessWidget {
  final String name;
  final String startTime; // Preformatted date
  final String contestId;

  const ContestCard({
    super.key,
    required this.name,
    required this.startTime,
    required this.contestId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text("Starts at: $startTime"),
        trailing: Text("ID: $contestId"),
      ),
    );
  }
}
