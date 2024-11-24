import 'package:cp_api/models/codeforces_model.dart';
import 'package:cp_api/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../provider/api.dart';

class ContestScreen extends StatefulWidget {
  final String? selectedPlatform;
  final String? username;
  final String? contestID;
  final ContestMode contestMode;

  ContestScreen.code({
    super.key,
    required this.selectedPlatform,
    required this.username,
    required this.contestID,
  }) : contestMode = ContestMode.code;

  ContestScreen({
    super.key,
    required this.selectedPlatform,
    required this.username,
    required this.contestMode,
  }) : contestID = null;

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  CodeforcesContest codeforcesContest = CodeforcesContest();
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadContestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.contestMode == ContestMode.latest ? "Latest " : widget.contestMode == ContestMode.ongoing ? "Ongoing " : ""}Contest Standings'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshContestData,
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        children: [
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (errorMessage != null) _buildErrorState(),
          if (errorMessage == null &&
              !isLoading &&
              codeforcesContest.contestId == null)
            _buildEmptyState(),
          if (codeforcesContest.contestId != null && !isLoading)
            _buildContestDetails(),
        ],
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
            onPressed: _refreshContestData,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "No contest data available.",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContestDetails() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text(
            '${codeforcesContest.contestName}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Contest ID: ${codeforcesContest.contestId}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Contest Platform: ${widget.selectedPlatform}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          if (codeforcesContest.standings!.isEmpty)
            const Center(
              child: Text(
                'The entered usernames did not participate in this contest.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          const SizedBox(height: 10),
          (codeforcesContest.standings!.isNotEmpty)?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Standings:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildStandingsTable(),
              ],
            ): const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildStandingsTable() {
    return Table(
      border: TableBorder.all(
          color: Colors.grey.shade400,
          width: 1,
          borderRadius: BorderRadius.circular(12)),
      columnWidths: const {
        0: FlexColumnWidth(0.2),
        1: FlexColumnWidth(0.4),
        2: FlexColumnWidth(0.2),
        3: FlexColumnWidth(0.2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          children: [
            _buildTableCell('Rank', isHeader: true),
            _buildTableCell('Handle', isHeader: true),
            _buildTableCell('Points', isHeader: true),
            _buildTableCell('Penalty', isHeader: true),
          ],
        ),
        for (var standings in codeforcesContest.standings!)
          TableRow(
            children: [
              _buildTableCell(standings.rank.toString()),
              _buildTableCell(standings.handle.toString()),
              _buildTableCell(standings.points.toString()),
              _buildTableCell(
                standings.penalty.toString(),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _refreshContestData() {
    setState(() {
      codeforcesContest = CodeforcesContest();
      errorMessage = null;
      isLoading = true;
    });
    _loadContestData();
  }

  Future<void> _loadContestData() async {
    if (widget.contestMode == ContestMode.code) {
      await _fetchContestData(() async {
        return await API.getContest(
          widget.selectedPlatform!.toLowerCase(),
          widget.username!,
          widget.contestID!,
        );
      });
    } else if (widget.contestMode == ContestMode.latest) {
      await _fetchContestData(() async {
        return await API.getContestLatest(
          widget.selectedPlatform!.toLowerCase(),
          widget.username!,
        );
      });
    } else if (widget.contestMode == ContestMode.ongoing) {
      await _fetchContestData(() async {
        return await API.getContestCurrent(
          widget.selectedPlatform!.toLowerCase(),
          widget.username!,
        );
      });
    }
  }

  Future<void> _fetchContestData(
      Future<CodeforcesContest> Function() api) async {
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
