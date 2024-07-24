import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SettingsScreen extends StatelessWidget {
  final Function(Locale) changeLanguage;

  SettingsScreen({required this.changeLanguage});

  // Function to update user profile details
  Future<void> _updateUserProfile(String firstName, String lastName, String mobileNumber, String email) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'email': email,
      });
    }
  }

  // Function to delete user account
  Future<void> _deleteUserAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Delete user data from Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
      // Delete user account
      await user.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Edit Name'),
            onTap: () {
              Navigator.pushNamed(context, '/editName');
            },
          ),

          ListTile(
            title: Text('Terms and Conditions'),
            onTap: () {
              Navigator.pushNamed(context, '/termsAndConditions');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () async {
              bool? confirmLogout = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirmLogout == true) {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
