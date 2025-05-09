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

  final FlutterSecureStorage _storage = FlutterSecureStorage();
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

  Future<void> confirmBooking() async {
    if (selectedVehicle != null &&
        selectedDestination != null &&
        selectedDate != null &&
        selectedTime != null &&
        bookingId != null) {
      // Retrieve the user ID from secure storage
      final userId = await _storage.read(key: 'userId');
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in. Please log in first.')),
        );
        return;
      }

      final url = '${Config.baseUrl}/confirm-booking';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': int.parse(userId),
          // Convert userId from String to int if needed
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
          SnackBar(
              content: Text('Failed to confirm booking. Please try again.')),
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


class HotelsScreen extends StatefulWidget {
  @override
  _HotelsScreenState createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String? selectedDistrict;
  String? selectedHotel;
  String? selectedRoomType;
  double pricePerNight = 0;
  int numberOfDays = 1;
  double totalAmount = 0;
  DateTime? selectedDate;
  int? selectedHotelId; // To store the selected hotel ID

  final List<String> districts = [
    'Colombo', 'Gampaha', 'Kalutara', 'Kandy', 'Matale', 'Nuwara Eliya',
    'Galle', 'Matara', 'Hambantota', 'Jaffna', 'Kilinochchi', 'Mannar',
    'Vavuniya', 'Mullaitivu', 'Batticaloa', 'Ampara', 'Trincomalee',
    'Kurunegala', 'Puttalam', 'Anuradhapura', 'Polonnaruwa', 'Badulla',
    'Monaragala', 'Ratnapura', 'Kegalle'
  ];

  List<Map<String, dynamic>> hotels = [];

  Future<void> fetchHotels(String district) async {
    final url = '${Config.baseUrl}/hotels';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'district': district}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          hotels = data.map((hotel) => {
            'id': hotel['id'], // Store hotel ID
            'hotel_name': hotel['hotel_name'],
            'price_single': hotel['price_single'],
            'price_double': hotel['price_double'],
            'price_family': hotel['price_family']
          }).toList();
          selectedHotel = null; // Reset selected hotel when district changes
          selectedHotelId = null; // Reset hotel ID
        });
      } else {
        print('Failed to load hotels: ${response.body}');
      }
    } catch (e) {
      print('Error fetching hotels: $e');
    }
  }

  void updateTotalAmount() {
    setState(() {
      totalAmount = pricePerNight * numberOfDays;
    });
  }

  Future<void> confirmBooking2() async {
    if (selectedHotelId == null || selectedRoomType == null || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select all booking details.')),
      );
      return;
    }

    // Retrieve the user ID from secure storage
    final userId = await _storage.read(key: 'userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in. Please log in first.')),
      );
      return;
    }

    final url = '${Config.baseUrl}/confirm-booking/hotels';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': int.parse(userId), // Convert userId from String to int if needed
        'hotel_id': selectedHotelId,
        'room_type': selectedRoomType,
        'days': numberOfDays,
        'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
        'total_price': totalAmount,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking confirmed successfully!')),
      );

      // Reset booking form after confirmation
      setState(() {
        selectedDistrict = null;
        selectedHotel = null;
        selectedHotelId = null;
        selectedRoomType = null;
        selectedDate = null;
        pricePerNight = 0;
        numberOfDays = 1;
        totalAmount = 0;
        hotels = [];
      });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select District', border: OutlineInputBorder()),
              value: selectedDistrict,
              items: districts.map((district) {
                return DropdownMenuItem(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  hotels = []; // Clear previous hotels when a new district is selected
                  selectedHotel = null; // Reset the selected hotel
                  fetchHotels(value!); // Fetch hotels for the selected district
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Hotel', border: OutlineInputBorder()),
              value: selectedHotel,
              items: hotels.map<DropdownMenuItem<String>>((hotel) {
                return DropdownMenuItem<String>(
                  value: hotel['hotel_name'] as String,
                  child: Text(hotel['hotel_name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedHotel = value;

                  // Safely find the selected hotel data
                  final selectedHotelData = hotels.firstWhere(
                        (hotel) => hotel['hotel_name'] == selectedHotel,
                  );

                  selectedHotelId = selectedHotelData['id']; // Store hotel ID
                  pricePerNight = double.tryParse(selectedHotelData['price_single'].toString()) ?? 0.0;
                  selectedRoomType = 'single';
                  updateTotalAmount();
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Select Room Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _roomTypeOption('🛏️', 'Single', 'single', 1, price: 'price_single'),
                _roomTypeOption('🛏️🛏️', 'Double', 'double', 2, price: 'price_double'),
                _roomTypeOption('🏠', 'Family', 'family', 8, price: 'price_family'),
              ],
            ),
            const SizedBox(height: 30),
            TextFormField(
              readOnly: true,
              controller: TextEditingController(
                text: selectedDate != null
                    ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                    : 'Select Date',
              ),
              decoration: InputDecoration(
                labelText: 'Select Date',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Number of Days', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (numberOfDays > 1) {
                          setState(() {
                            numberOfDays--;
                            updateTotalAmount();
                          });
                        }
                      },
                    ),
                    Text(numberOfDays.toString(), style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          numberOfDays++;
                          updateTotalAmount();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Total Amount: LKR $totalAmount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
      ElevatedButton(
        onPressed: confirmBooking2,
        style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: Text(
              'Confirm Booking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }

  Widget _roomTypeOption(String emoji, String label, String type, int persons, {required String price}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRoomType = type;

          if (selectedHotel != null && selectedDistrict != null) {
            // Convert the price string to a double
            final selectedHotelData = hotels.firstWhere((hotel) => hotel['hotel_name'] == selectedHotel);
            pricePerNight = double.tryParse(selectedHotelData[price].toString()) ?? 0.0;
            updateTotalAmount();
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selectedRoomType == type ? Colors.blue[100] : Colors.white,
          border: Border.all(
            color: selectedRoomType == type ? Colors.blue : Colors.grey[300]!,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: 30)),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '($persons Persons)',
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketsScreen extends StatefulWidget {
  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  String? selectedDistrict;
  String? selectedTicket;
  int ticketQuantity = 1; // Initialize quantity
  double ticketPrice = 0.0;
  double totalAmount = 0.0;

  final _storage = const FlutterSecureStorage();

  List<Map<String, dynamic>> ticketOptions = []; // Dynamically fetched ticket options

  @override
  void initState() {
    super.initState();
    updateTotalAmount();
  }

  // Function to fetch tickets based on the selected district
  Future<void> fetchTicketsByDistrict(String district) async {
    final url = '${Config.baseUrl}/tickets';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'place': district}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          // Update the ticket options dynamically based on the response
          ticketOptions = data.map((ticket) {
            return {
              'id': ticket['id'],
              'name': ticket['ticket_name'],
              'price': double.tryParse(ticket['price'].toString()) ?? 0.0, // Ensure price is double
            };
          }).toList();
          selectedTicket = null;
          ticketPrice = 0.0;
          updateTotalAmount();
        });
      } else {
        print('Failed to load tickets: ${response.body}');
      }
    } catch (e) {
      print('Error fetching tickets: $e');
    }
  }

  void updateTotalAmount() {
    setState(() {
      totalAmount = ticketQuantity * ticketPrice;
    });
  }

  void clearSelection() {
    setState(() {
      selectedDistrict = null;
      selectedTicket = null;
      ticketQuantity = 1;
      ticketPrice = 0.0;
      totalAmount = 0.0;
      ticketOptions.clear();
    });
  }


  Future<void> updateBooking() async {
    final url = '${Config.baseUrl}/book-tickets/${selectedTicket}'; // Replace selectedTicket with booking_id or unique identifier for the booking

    try {
      final userId = await _storage.read(key: 'userId');

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User ID is not available')),
        );
        return;
      }

      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': int.parse(userId),
          'ticket_name': selectedTicket,
          'number_of_tickets': ticketQuantity,
          'total_price': totalAmount,
          'date': DateTime.now().toIso8601String().split('T').first, // Current date in YYYY-MM-DD format
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful update
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Booking updated successfully!'),
        ));

        clearSelection();

        // Navigate to BookingSuccessScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingSuccessScreen()),
        );
      } else {
        print('Failed to update booking: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update booking.'),
        ));
      }
    } catch (e) {
      print('Error updating booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating booking.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select District',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                border: OutlineInputBorder(),
              ),
              value: selectedDistrict,
              items: [
                'Ampara', 'Anuradhapura', 'Badulla', 'Batticaloa', 'Colombo',
                'Galle', 'Gampaha', 'Hambantota', 'Jaffna', 'Kalutara', 'Kandy',
                'Kegalle', 'Kilinochchi', 'Kurunegala', 'Mannar', 'Matale',
                'Matara', 'Monaragala', 'Mullaitivu', 'Nuwara Eliya',
                'Polonnaruwa', 'Puttalam', 'Ratnapura', 'Trincomalee', 'Vavuniya'
              ].map((district) {
                return DropdownMenuItem(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  ticketOptions.clear();
                  selectedTicket = null;
                  ticketPrice = 0.0;
                  fetchTicketsByDistrict(value!); // Fetch tickets for the selected district
                });
              },
            ),
            SizedBox(height: 15.0),
            Text('Select Ticket', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            // Displaying ticket options as radio buttons
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: ticketOptions.map((ticket) {
                return RadioListTile<String>(
                  title: Text(ticket['name']),
                  subtitle: Text("Price: LKR ${ticket['price']}"),
                  value: ticket['name'],
                  groupValue: selectedTicket,
                  onChanged: (value) {
                    setState(() {
                      selectedTicket = value;
                      // Find the selected ticket's price and update it
                      ticketPrice = ticketOptions.firstWhere(
                            (t) => t['name'] == value,
                        orElse: () => {'price': 0.0},
                      )['price'];
                      updateTotalAmount();
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Number of Tickets',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (ticketQuantity > 1) {
                          setState(() {
                            ticketQuantity--;
                            updateTotalAmount();
                          });
                        }
                      },
                    ),
                    Text(ticketQuantity.toString(), style: TextStyle(fontSize: 16.0)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          ticketQuantity++;
                          updateTotalAmount();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Total Amount: LKR $totalAmount',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007AFF), // Blue background color
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
                onPressed: () {
                  if (selectedDistrict == null || selectedTicket == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please select all booking details.'),
                    ));
                    return;
                  }

                  // Call the update function and show success message if update is successful
                  updateBooking();
                },
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
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


class MyBookingsScreen extends StatefulWidget {
  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  double travelsTotal = 0.0;
  double hotelsTotal = 0.0;
  double ticketsTotal = 0.0;
  double grandTotal = 0.0;
  bool isLoading = true;
  List<Map<String, dynamic>> travelBookings = [];
  List<Map<String, dynamic>> hotelBookings = [];

  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
    fetchUserTravelBookings();
    fetchUserHotelBookings();
    fetchUserTicketBookings(); // Fetch ticket bookings
  }

  Future<void> fetchTotalAmount() async {
    final userId = await _storage.read(key: 'userId');
    final url = '${Config.baseUrl}/total-amount/$userId';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          travelsTotal = double.parse(data['travelsTotal']);
          hotelsTotal = double.parse(data['hotelsTotal']);
          ticketsTotal = double.parse(data['ticketsTotal']);
          grandTotal = double.tryParse(data['grandTotal'].toString()) ?? 0.0;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchUserTravelBookings() async {
    final userId = await _storage.read(key: 'userId');
    final url = '${Config.baseUrl}/user-travels/$userId';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          travelBookings = List<Map<String, dynamic>>.from(data.map((item) {
            return {
              'id': item['id'],
              'date': item['date'],
              'time': item['time'],
              'total_price': double.tryParse(item['total_price'].toString()) ?? 0.0,  // Convert total_price to double
              'vehicle_name': item['vehicle_name'],
              'place': item['place'],
            };
          }));
        });
      } else {
        print('Failed to fetch travel bookings: ${response.body}');
      }
    } catch (e) {
      print('Error fetching travel bookings: $e');
    }
  }


  Future<void> fetchUserHotelBookings() async {
    final userId = await _storage.read(key: 'userId');
    final url = '${Config.baseUrl}/user-hotels/$userId';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          hotelBookings = List<Map<String, dynamic>>.from(data.map((item) {
            return {
              'id': item['id'],
              'hotel_name': item['hotel_name'],
              'place': item['place'],
              'date': item['date'],
              'days': item['days'],
              'total_price': double.tryParse(item['total_price'].toString()) ?? 0.0,  // Convert to double
            };
          }));
        });
      } else {
        print('Failed to fetch hotel bookings: ${response.body}');
      }
    } catch (e) {
      print('Error fetching hotel bookings: $e');
    }
  }

  List<Map<String, dynamic>> ticketBookings = []; // List to store ticket bookings

  Future<void> fetchUserTicketBookings() async {
    final userId = await _storage.read(key: 'userId');
    final url = '${Config.baseUrl}/user-tickets/$userId';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          ticketBookings = List<Map<String, dynamic>>.from(data.map((item) {
            return {
              'id': item['id'],
              'ticket_name': item['ticket_name'],
              'number_of_tickets': item['number_of_tickets'],
              'total_price': double.tryParse(item['total_price'].toString()) ?? 0.0, // Convert to double
              'date': item['date'],
            };
          }));
        });
      } else {
        print('Failed to fetch ticket bookings: ${response.body}');
      }
    } catch (e) {
      print('Error fetching ticket bookings: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          title: Text(
            'Grand Total: ${grandTotal.toStringAsFixed(0)} LKR',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.black,
            tabs: [
              Tab(child: Text('Travels', style: TextStyle(fontWeight: FontWeight.bold))),
              Tab(child: Text('Hotels', style: TextStyle(fontWeight: FontWeight.bold))),
              Tab(child: Text('Tickets', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
          children: [
            buildTravelsTab(),
            buildHotelsTab(),
            buildTicketsTab(), // Display ticket bookings in a list
          ],
        ),
      ),
    );
  }

  Widget buildTravelsTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Total: ${travelsTotal.toStringAsFixed(0)} LKR',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: travelBookings.length,
            itemBuilder: (context, index) {
              final booking = travelBookings[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['vehicle_name'] ?? '',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Place: ${booking['place'] ?? ''}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Date: ${booking['date']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Time: ${booking['time']}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${(booking['total_price'] as double).toStringAsFixed(0)} LKR',  // Cast to double just to be safe
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }



  Widget buildHotelsTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Total: ${hotelsTotal.toStringAsFixed(0)} LKR',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: hotelBookings.length,
            itemBuilder: (context, index) {
              final booking = hotelBookings[index];
              return buildBookingCard(
                title: booking['hotel_name'],
                place: booking['place'],
                date: booking['date'],
                time: 'Days: ${booking['days']}',
                totalPrice: booking['total_price'],
              );
            },
          ),
        ),
      ],
    );
  }

// Helper method to build a booking card
  Widget buildBookingCard({
    required String title,
    required String place,
    required String date,
    required String time,
    required double totalPrice,  // Expect totalPrice to be a double
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Place: $place',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Date: $date',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Text(
              '${totalPrice.toStringAsFixed(0)} LKR',  // Format the price as needed
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildTicketsTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Total: ${ticketsTotal.toStringAsFixed(0)} LKR',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ticketBookings.length,
            itemBuilder: (context, index) {
              final booking = ticketBookings[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['ticket_name'] ?? '',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Date: ${booking['date'] ?? ''}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Tickets: ${booking['number_of_tickets']}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${(booking['total_price'] as double).toStringAsFixed(0)} LKR',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget buildTabContent(String totalText, String contentText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            totalText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Center(child: Text(contentText)),
        ),
      ],
    );
  }
}





