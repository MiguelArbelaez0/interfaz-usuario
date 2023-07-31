import 'package:flutter/material.dart';

import '../home/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 8, 49, 0.9),
      body: ListView(
        children: [
          SizedBox(
            height: 243,
          ),
          Container(
            width: 275,
            height: 171,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/food_splah_screen.png'),
              ),
            ),
          ),
          SizedBox(
            height: 49,
          ),
          Container(
            width: 263,
            height: 36,
            alignment: Alignment.center,
            child: Text(
              'Food Ordering App',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: "Poppins-Bold.ttf",
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 49,
          ),
          Container(
            width: 339,
            height: 59,
            margin: EdgeInsets.only(left: 17, right: 19),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(254, 151, 74, 1)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text(
                  'Get Meal',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
