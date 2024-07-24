import 'package:flutter/material.dart';
import 'package:my_chat/screens/login.dart';
import 'make_payment.dart';

class ChooseProduct extends StatefulWidget {
  @override
  _ChooseProductState createState() => _ChooseProductState();
}

class _ChooseProductState extends State<ChooseProduct> {
  int _currentPage = 0;
  PageController _pageController = PageController();

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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.black87),

            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
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
                              'images/img_1.png',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Choose Products',
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
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 1; i++)
                      Container(
                        width: 10,
                        height: 10,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? Colors.blue
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakePayment(currentPage: _currentPage + 1),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
