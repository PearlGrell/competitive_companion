import 'dart:developer';

import 'package:cp_api/screens/contest_screen.dart';
import 'package:cp_api/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UsernamesInputScreen extends StatefulWidget {
  final ContestMode contestMode;

  const UsernamesInputScreen({super.key, required this.contestMode});

  @override
  UsernamesInputScreenState createState() => UsernamesInputScreenState();
}

class UsernamesInputScreenState extends State<UsernamesInputScreen> {
  List<TextEditingController> usernameControllers = [TextEditingController()];
  TextEditingController contestCodeController = TextEditingController();

  List platformList = ["Codeforces", "Codechef", "Leetcode", "GeeksForGeeks"];

  String selectedPlatform = "Codeforces";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.contestMode == ContestMode.latest ? "Latest" : widget.contestMode == ContestMode.ongoing ? "Ongoing" : ""} Contests Standings"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String combinedUsernames = usernameControllers
              .map((controller) => controller.text)
              .where((text) => text.isNotEmpty)
              .join(';');
          if (combinedUsernames.isNotEmpty) {
            if (widget.contestMode == ContestMode.code) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContestScreen.code(
                    selectedPlatform: selectedPlatform,
                    username: combinedUsernames,
                    contestID: contestCodeController.text.trim(),
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContestScreen(
                    selectedPlatform: selectedPlatform,
                    username: combinedUsernames,
                    contestMode: widget.contestMode,
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please enter at least one username'),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0
                ),
                child: DropdownButton(
                  items: getPlatforms(),
                  isExpanded: true,
                  value: selectedPlatform,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (value) {
                    setState(() {
                      selectedPlatform = value.toString();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < usernameControllers.length; i++) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: usernameControllers[i],
                      decoration: InputDecoration(
                        hintText: 'Username ${i + 1}',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    icon: Icon(
                      i == usernameControllers.length - 1
                          ? Icons.add
                          : Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (i == usernameControllers.length - 1) {
                          usernameControllers.add(TextEditingController());
                        } else {
                          usernameControllers.removeAt(i);
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            const Divider(),
            const SizedBox(height: 16),
            if (widget.contestMode == ContestMode.code)
              TextField(
                controller: contestCodeController,
                decoration: const InputDecoration(
                  hintText: 'Contest Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> getPlatforms() {
    return platformList
        .map((platform) => DropdownMenuItem(
              value: platform,
              child: Text(platform),
            ))
        .toList();
  }
}
