import 'package:flutter/material.dart';

class APIIntegrationScreen extends StatelessWidget {
  const APIIntegrationScreen({super.key});

  Widget _buildEndpointInfo(
      String path, String method, String description, String example, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Path: $path",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text("Method: $method"),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                text: "Description: ",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 16),
                children: [
                  TextSpan(
                    text: description,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                text: "Example: ",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to the Competitive Programming API!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "This API provides data and contest information from platforms like Codeforces, CodeChef, GeeksForGeeks, and LeetCode.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              const Text(
                "Endpoints:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildEndpointInfo(
                "/fetch/:platform/:username",
                "GET",
                "Fetch user data from a specific platform.",
                "/fetch/codechef/aryan_trivedi",
                context
              ),
              _buildEndpointInfo(
                "/fetch-all/:username",
                "GET",
                "Fetch user data from all supported platforms.",
                "/fetch-all/aryan_trivedi",
                context
              ),
              _buildEndpointInfo(
                "/contest/:platform",
                "POST",
                "Fetch contest standings for a given platform and contest ID.",
                "/contest/codeforces",
                context
              ),
              _buildEndpointInfo(
                "/contest/:platform/latest",
                "POST",
                "Fetch the latest finished contest standings for a given platform.",
                "/contest/codeforces/latest",
                context
              ),
              _buildEndpointInfo(
                "/contest/:platform/current",
                "POST",
                "Fetch ongoing contest standings for a given platform.",
                "/contest/codeforces/current",
                context
              ),
              _buildEndpointInfo(
                "/contest/:platform/upcoming",
                "GET",
                "Fetch upcoming contests for a specific platform.",
                "/contest/codeforces/upcoming",
                context
              ),
            ],
          ),
        ),
      ),
    );
  }
}
