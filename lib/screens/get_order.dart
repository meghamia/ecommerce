import 'package:flutter/material.dart';
import 'package:my_chat/screens/login.dart';

import 'make_payment.dart';

class GetOrder extends StatefulWidget {
  final int currentPage;

  GetOrder({required this.currentPage});

  @override
  _GetOrderState createState() => _GetOrderState();
}

class _GetOrderState extends State<GetOrder> {
  int _currentPage = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_currentPage + 1}/3'),
        actions: [
          TextButton(
            onPressed: () {
              // Skip button action
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/img_3.png',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Get Order',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakePayment(currentPage: _currentPage - 1),
                  ),
                );
              },
              child: Text('Prev', style: TextStyle(color: Colors.black87)),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                // Define the action when the Next button is pressed
              },
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
