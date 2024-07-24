import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNameScreen extends StatefulWidget {
  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          _firstNameController.text = doc['firstName'] ?? '';
          _lastNameController.text = doc['lastName'] ?? '';
          _mobileNumberController.text = doc['mobileNumber'] ?? '';
          _emailController.text = doc['email'] ?? '';
        });
      }
    }
  }

  Future<void> _saveChanges() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'mobileNumber': _mobileNumberController.text,
        'email': _emailController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _mobileNumberController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
