import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            "By placing an order, you agree to pay the specified price. Payment information must be valid, and you authorize us to "
                "charge your payment method."
                " We reserve the right to cancel orders if necessary."
                ""
                "We offer various shipping options, and delivery times are estimates. We are not responsible for delays caused by shipping carriers. For any delivery issues, please contact the carrier directly."
                "You agree not to use the app for illegal purposes or in a way that could harm others. This includes not interfering with the app's functionality or violating its terms."
                "We are not liable for any indirect or consequential damages arising from your use of the app. Our liability is limited to the fullest extent permitted by law.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
