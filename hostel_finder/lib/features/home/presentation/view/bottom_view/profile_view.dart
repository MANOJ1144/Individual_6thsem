import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/rajpal.png', // Replace with your profile image path
              ),
              radius: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              'Rajpal Yadav', // Replace with user's name
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'rajpal@example.com', // Replace with user's email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _editProfile(); // Call your edit profile logic here
              },
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Brand Bold',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _signOut(); // Call your sign out logic here
              },
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Brand Bold',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    // Implement your logic for editing the profile
    // For example, navigate to an edit profile screen
    Navigator.pushNamed(context, '/editProfile');
  }

  void _signOut() {
    // Implement your logic for signing out
    // For example, clear user session and navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}
