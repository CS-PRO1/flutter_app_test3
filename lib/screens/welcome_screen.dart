import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cache/cache.dart';
import 'package:flutter_application_3/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  List titles = [
    'Welcome to BigMall!',
    'We have SALES!',
    'Fun for All the Family'
  ];

  List texts = [
    'Come and visit us!',
    'sales on all products for a limited time! \n up to 50%!',
    'Visit our many stores today!'
  ];

  List images = [
    'images/welcome/first.jpg',
    'images/welcome/second.jpg',
    'images/welcome/third.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    bool isLast = false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          AppBar(elevation: 0, backgroundColor: Colors.transparent, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Card(
            elevation: 10,
            child: TextButton(
              onPressed: () {
                CacheHelper.setBool('on_board', true);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              child: Text(
                'SKIP',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ]),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: (value) {
                value == titles.length - 1 ? isLast = true : isLast = false;
              },
              children: [
                Column(children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(titles[0],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(texts[0], style: TextStyle(fontSize: 20))
                ]),
                Column(children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    child: Image.asset(
                      images[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(titles[1],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    texts[1],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                ]),
                Column(children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    child: Image.asset(
                      images[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(titles[2],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(texts[2], style: TextStyle(fontSize: 20))
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: ExpandingDotsEffect(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isLast) {
              CacheHelper.setBool('on_board', true);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            } else {
              pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Icon(Icons.arrow_forward_ios)),
    );
  }
}
