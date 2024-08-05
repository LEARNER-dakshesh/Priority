import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Map to track lock states for each item
  Map<int, bool> _lockStates = {
    0: false, // Instagram
    1: false, // Facebook
    2: false, // Snapchat
    3: false, // LinkedIn
    4: false, // YouTube
  };

  void _toggleLock(int index) {
    setState(() {
      _lockStates[index] = !_lockStates[index]!; // Toggle the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        title: Text(
          'Priority',
          style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 25)),
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(bottom: 80.0),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            SizedBox(height: 10.0),
            _buildListTile('Assets/insta.png', 'Instagram', 0),
            SizedBox(height: 10.0),
            _buildListTile('Assets/facebook.png', 'Facebook', 1),
            SizedBox(height: 10.0),
            _buildListTile('Assets/snap.png', 'Snapchat', 2),
            SizedBox(height: 10.0),
            _buildListTile('Assets/linkedin.png', 'LinkedIn', 3),
            SizedBox(height: 10.0),
            _buildListTile('Assets/youtube.png', 'YouTube', 4),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'Payment',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            selectedFontSize: 17,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(String imagePath, String title, int index) {
    return ListTile(
      leading: Image.asset(imagePath),
      title: Text(title, style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white, fontSize: 22))),
      trailing: GestureDetector(
        onTap: () => _toggleLock(index),
        child: Icon(
          _lockStates[index]! ? Icons.lock : Icons.lock_open,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = 30.0;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
