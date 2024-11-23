import 'package:flutter/material.dart';
import 'package:cp_api/api/api.dart';
import 'package:cp_api/models/codeforces_model.dart';
import 'package:cp_api/upcoming_contest_screen.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({super.key});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}
class _ContestScreenState extends State<ContestScreen> {
  TextEditingController usernameController = TextEditingController(
    text: "_a_u_r_o_r_a_;SadSock;nguyenkhangninh99;haminh1092005;aka26nsh",
  );

  TextEditingController contestIDController = TextEditingController(
    text: "2037",
  );

  String selectedPlatform = 'Codeforces';
  CodeforcesContest codeforcesContest = CodeforcesContest();

  final List<String> platforms = [
    'Codeforces',
    'LeetCode',
    'CodeChef',
    'GeeksForGeeks'
  ];

  bool isLoading = false; 
  String? errorMessage; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpcomingContestScreen(),
            ),
          );
        },
        child: const Icon(Icons.upcoming),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsets.all(MediaQuery.of(context).size.width * 0.048),
              child: TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Usernames',
                  hintText: 'Enter your usernames',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                          MediaQuery.of(context).size.width * 0.024),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.all(MediaQuery.of(context).size.width * 0.048),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: contestIDController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Contest ID',
                        hintText: 'Enter contest ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                MediaQuery.of(context).size.width * 0.024),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.048),
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      value: selectedPlatform,
                      items: platforms.map((String platform) {
                        return DropdownMenuItem<String>(
                          value: platform,
                          child: Text(platform),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPlatform = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Platform',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                MediaQuery.of(context).size.width * 0.024),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.048),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FilledButton(
                      onPressed: isLoading ? null : _handleLatestContest,
                      child: const Text(
                        'Fetch Latest Contest',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Flexible(
                    child: FilledButton(
                      onPressed: isLoading ? null : _handleContest,
                      child: const Text(
                        'Fetch Contest ID',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Flexible(
                    child: FilledButton(
                      onPressed: isLoading ? null : _handleCurrentContest,
                      child: const Text(
                        'Fetch Ongoing Contest',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const CircularProgressIndicator(), 
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child: codeforcesContest.contestId == null
                  ? const Center(
                child: Text(
                  'No contest data available.',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  const Text(
                    'Contest Details:',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contest ID: ${codeforcesContest.contestId}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Contest Name: ${codeforcesContest.contestName}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Standings:',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (codeforcesContest.standings != null)
                    ...codeforcesContest.standings!.map(
                          (standings) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rank: ${standings.rank}'),
                              Text('Handle: ${standings.handle}'),
                              Text('Points: ${standings.points}'),
                              Text('Penalty: ${standings.penalty}'),
                              if (standings.successfulHackCount != null &&
                                  standings.successfulHackCount != 0)
                                Text(
                                  'Successful Hack Count: ${standings.successfulHackCount}',
                                ),
                              if (standings.unsuccessfulHackCount !=
                                  null &&
                                  standings.unsuccessfulHackCount != 0)
                                Text(
                                  'Unsuccessful Hack Count: ${standings.unsuccessfulHackCount}',
                                ),
                              if (standings.problemResults != null)
                                Text(
                                  'Problems Attempted: ${standings.problemResults!.length}',
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLatestContest() async {
    await _fetchContestData(() async {
      return await API.getContestLatest(
        selectedPlatform.toLowerCase(),
        usernameController.text.split(';'),
      );
    });
  }

  Future<void> _handleContest() async {
    await _fetchContestData(() async {
      return await API.getContest(
        selectedPlatform.toLowerCase(),
        usernameController.text.split(';'),
        contestIDController.text.trim(),
      );
    });
  }

  Future<void> _handleCurrentContest() async {
    await _fetchContestData(() async {
      return await API.getContestCurrent(
        selectedPlatform.toLowerCase(),
        usernameController.text.split(';'),
      );
    });
  }

  Future<void> _fetchContestData(Future<CodeforcesContest> Function() api) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final contest = await api();
      setState(() {
        codeforcesContest = contest;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
