import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config.dart';
import 'booking_success_screen.dart';
import 'profile_info.dart';
import 'change_password.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';


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



class TravelTab extends StatefulWidget {
  @override
  _TravelTabState createState() => _TravelTabState();
}




class _TravelTabState extends State<TravelTab> {
  String? selectedVehicle;
  String? selectedDestination;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final fromLocation = 'Colombo Airport';
  double? fetchedPrice;
  int? bookingId;

  final List<String> districts = [
    'Colombo', 'Gampaha', 'Kalutara', 'Kandy', 'Matale', 'Nuwara Eliya',
    'Galle', 'Matara', 'Hambantota', 'Jaffna', 'Kilinochchi', 'Mannar',
    'Vavuniya', 'Mullaitivu', 'Batticaloa', 'Ampara', 'Trincomalee',
    'Kurunegala', 'Puttalam', 'Anuradhapura', 'Polonnaruwa', 'Badulla',
    'Monaragala', 'Ratnapura', 'Kegalle'
  ];

  void selectVehicle(String vehicle) {
    setState(() {
      selectedVehicle = vehicle;
      fetchedPrice = null;
      fetchPrice();
    });
  }

  void selectDestination(String? destination) {
    setState(() {
      selectedDestination = destination;
      fetchedPrice = null;
      fetchPrice();
    });
  }


  // Method to select date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked; // Update only the date
      });
    }
  }

// Method to select time
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked; // Update only the time
      });
    }
  }


  Future<void> fetchPrice() async {
    if (selectedVehicle != null && selectedDestination != null) {
      final url = '${Config.baseUrl}/get_price';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'vehicle_name': selectedVehicle,
          'place': selectedDestination,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          bookingId = data['booking_id'];
          fetchedPrice = double.tryParse(data['price'].toString());
          print('Fetched booking ID: $bookingId, Price: $fetchedPrice');
        });
      } else {
        final errorData = jsonDecode(response.body);
        setState(() {
          fetchedPrice = null;
          bookingId = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorData['error'] ?? 'Failed to fetch price. Please try again.',
            ),
          ),
        );
      }
    }
  }
  @override
  // Define controllers for date and time fields
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

// Updated confirmBooking method
  Future<void> confirmBooking() async {
    if (selectedVehicle != null &&
        selectedDestination != null &&
        selectedDate != null &&
        selectedTime != null &&
        bookingId != null) {
      final url = '${Config.baseUrl}/confirm-booking';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': 1, // Replace with actual user ID
          'booking_id': bookingId,
          'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
          'time': selectedTime!.format(context),
          'total_price': fetchedPrice,
        }),
      );

      if (response.statusCode == 201) {

        // Reset form fields including controllers
        resetForm();

        // Navigate to BookingSuccessScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingSuccessScreen()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to confirm booking. Please try again.')),
        );
      }
    }
  }

// Method to reset form fields to their initial state
  void resetForm() {
    setState(() {
      selectedVehicle = null;
      selectedDestination = null;
      selectedDate = null;
      selectedTime = null;
      bookingId = null;
      fetchedPrice = null;

      // Clear text controllers
      dateController.clear();
      timeController.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Vehicle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VehicleCard(
                  emoji: '🛺',
                  vehicleType: '3 Wheeler',
                  capacity: '3 Persons',
                  isSelected: selectedVehicle == '3 Wheeler',
                  onTap: () => selectVehicle('3 Wheeler'),
                ),
                VehicleCard(
                  emoji: '🚗',
                  vehicleType: 'Car',
                  capacity: '5 Persons',
                  isSelected: selectedVehicle == 'Car',
                  onTap: () => selectVehicle('Car'),
                ),
                VehicleCard(
                  emoji: '🚐',
                  vehicleType: 'Van',
                  capacity: '15 Persons',
                  isSelected: selectedVehicle == 'Van',
                  onTap: () => selectVehicle('Van'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'From: $fromLocation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Destination',
                border: OutlineInputBorder(),
              ),
              value: selectedDestination,
              items: districts.map((district) {
                return DropdownMenuItem(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: selectDestination,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: dateController, // Use controller for date field
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Select date',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                await selectDate(context);
                if (selectedDate != null) {
                  dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!); // Update only date
                }
              },
            ),
            const SizedBox(height: 10),
          TextFormField(
            controller: timeController, // Use controller for time field
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Time',
              hintText: 'Select time',
              suffixIcon: Icon(Icons.access_time),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              await selectTime(context);
              if (selectedTime != null) {
                // Update timeController with 24-hour format
                final now = DateTime.now();
                final selectedDateTime = DateTime(now.year, now.month, now.day, selectedTime!.hour, selectedTime!.minute);
                timeController.text = DateFormat('HH:mm').format(selectedDateTime); // 24-hour format
              }
            },
          ),
            const SizedBox(height: 20),
            if (fetchedPrice != null)
              Column(
                children: [
                  Text(
                    'Estimated Price: LKR $fetchedPrice',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: confirmBooking,
                      child: Text(
                        'Confirm Booking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Color(0xFF1E88E5),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

}

class VehicleCard extends StatelessWidget {
  final String emoji;
  final String vehicleType;
  final String capacity;
  final bool isSelected;
  final VoidCallback onTap;

  const VehicleCard({
    Key? key,
    required this.emoji,
    required this.vehicleType,
    required this.capacity,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: 100,
            height: 130,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emoji, style: TextStyle(fontSize: 40)),
                Divider(color: Colors.grey),
                Text(
                  vehicleType,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '($capacity)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.check_circle, color: Colors.blueAccent),
            ),
        ],
      ),
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
