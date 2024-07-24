import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final String oobCode; // Out Of Band code from the password reset link

  ResetPasswordScreen({required this.oobCode});

  Future<void> confirmPasswordReset(String newPassword) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: oobCode,
        newPassword: newPassword,
      );
      Get.snackbar('Password Reset Successful', 'Your password has been reset',
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      print('Error resetting password: $e');
      Get.snackbar('Password Reset Failed', 'Please try again',
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.pink[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                labelText: 'Enter new password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                final newPassword = newPasswordController.text.trim();
                if (newPassword.isNotEmpty) {
                  confirmPasswordReset(newPassword);
                } else {
                  Get.snackbar('Password Required', 'Please enter your new password',
                      snackPosition: SnackPosition.TOP);
                }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
