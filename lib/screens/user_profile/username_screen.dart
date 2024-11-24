import 'package:cp_api/screens/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  UsernamePageState createState() => UsernamePageState();
}

class UsernamePageState extends State<UsernamePage> {
  bool useCommonUsername = true;
  final TextEditingController commonUsernameController =
      TextEditingController();
  final TextEditingController codeforcesController = TextEditingController();
  final TextEditingController codechefController = TextEditingController();
  final TextEditingController leetcodeController = TextEditingController();
  final TextEditingController gfgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSubmit,
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please provide your usernames",
                style: TextStyle(
                  fontSize: screenWidth * 0.052,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              RadioListTile<bool>(
                title: const Text('Username is common for all platforms'),
                value: true,
                groupValue: useCommonUsername,
                onChanged: (value) {
                  setState(() {
                    useCommonUsername = value!;
                  });
                },
              ),
              if (useCommonUsername)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: _buildTextField(
                    controller: commonUsernameController,
                    label: 'Common Username',
                  ),
                ),
              RadioListTile<bool>(
                title: const Text('Username is different for each platform'),
                value: false,
                groupValue: useCommonUsername,
                onChanged: (value) {
                  setState(() {
                    useCommonUsername = value!;
                  });
                },
              ),
              if (!useCommonUsername) ...[
                _buildTextField(
                    controller: codeforcesController,
                    label: 'Codeforces Username'),
                _buildTextField(
                    controller: codechefController, label: 'CodeChef Username'),
                _buildTextField(
                    controller: leetcodeController, label: 'LeetCode Username'),
                _buildTextField(
                    controller: gfgController, label: 'GeeksForGeeks Username'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if((useCommonUsername && commonUsernameController.text.isEmpty) || (!useCommonUsername && (codeforcesController.text.isEmpty || codechefController.text.isEmpty || leetcodeController.text.isEmpty || gfgController.text.isEmpty))){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide the username/s')),
      );
    }
    else{
      if (useCommonUsername) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserProfileScreen.defaultUsername(defaultUsername: commonUsernameController.text);
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserProfileScreen.individualUsername(
                codeforcesUsername: codeforcesController.text,
                codechefUsername: codechefController.text,
                leetcodeUsername: leetcodeController.text,
                gfgUsername: gfgController.text,
              );
            },
          ),
        );
      }
    }
  }
}
