import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugashttp/home.dart';
import 'package:tugashttp/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences _prefs;
  String? _email;
  String? _password;
  String? _dob;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = _prefs.getString('email') ?? '';
      _password = _prefs.getString('password') ?? '';
      _dob = _prefs.getString('dob') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage('https://cdn.idntimes.com/content-images/post/20240207/18b9ffb2a8a791d50213a9d595c4dd52-2d5f4288845c5a0326913d5a017e0648.jpg'),
              ),
              SizedBox(height: 20),
              Text('Email: $_email'),
              Text('Password: $_password'),
              Text('Date of Birth: $_dob'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.brown,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.white),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.grey),
            label: 'Logout',
          ),
        ],
        onTap: (int index) async {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else if (index == 1) {
            //
          } else if (index == 2){
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          }
        },
      ),
    );
  }
}

