import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config.dart';
import 'profile_info.dart';
import 'change_password.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'message_sent_screen.dart';

const Color customOrange = Color(0xFF1A73E8); // Use your custom blue color here

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _storage = const FlutterSecureStorage();
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    TravelTab(),
    HotelsScreen(),
    TicketsScreen(),
    MyBookingsScreen(),
  ];

  static const List<String> _screenTitles = [
    'Travels',
    'Hotels',
    'Tickets',
    'My Bookings',
  ];

  Future<void> _logout(BuildContext context) async {
    await _storage.deleteAll();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
          (route) => false,
    );
  }

  void _handleMenuSelection(String choice) {
    switch (choice) {
      case 'Profile Info':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileInfoScreen()));
        break;
      case 'Change Password':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
        break;
      case 'Logout':
        _logout(context);
        break;
    }
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screenTitles[_selectedIndex],
          style: const TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A73E8), Color(0xFF4285F4)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuSelection,
            icon: const Icon(Icons.person, color: Colors.white),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'Profile Info', child: Text('Profile Info')),
              const PopupMenuItem<String>(value: 'Change Password', child: Text('Change Password')),
              const PopupMenuItem<String>(value: 'Logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Travels'),
          BottomNavigationBarItem(icon: Icon(Icons.hotel), label: 'Hotels'),
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'My Bookings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color(0xFF1A73E8),
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// You can replace OrganTab, MyMatchScreen, MyRequestsScreen, and MessageScreen with renamed classes as follows:

// Travels Tab
class TravelTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Travel Bookings will be shown here.'),
    );
  }
}

// Hotels Screen
class HotelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Hotel Bookings will be shown here.'),
    );
  }
}

// Tickets Screen
class TicketsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ticket Bookings will be shown here.'),
    );
  }
}

// My Bookings Screen
class MyBookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('All My Bookings will be shown here.'),
    );
  }
}
