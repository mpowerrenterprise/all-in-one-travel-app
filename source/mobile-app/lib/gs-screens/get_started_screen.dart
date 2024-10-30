import 'package:flutter/material.dart';

import 'gs_booking_travels_screen.dart';


class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App title at the top
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  'ALL IN ONE TRAVEL APP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    fontFamily: 'Helvetica',
                  ),
                ),
              ),
            ),
            // Image section
            Center(
              child: Image.asset(
                'assets/images/logo.png', // Ensure the image path is correct
                height: 400,
                width: 400,
              ),
            ),
            // Heading and description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    'Explore the World',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Plan and book every part of your journey in one app. From finding top-rated stays to discovering must-see attractions, we make travel simple and enjoyable.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Gradient button at the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to RequestOrgansScreen (replace with the relevant screen)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingTravelsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Let’s Go!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
}
