import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tugashttp/detail.dart';
import 'package:tugashttp/login.dart';
import 'package:tugashttp/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> breweries = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await http.get(Uri.parse('https://api.openbrewerydb.org/v1/breweries'));
    if (response.statusCode == 200) {
      setState(() {
        breweries = json.decode(response.body);
      });
    } else {
      print('Gagal memuat data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewery List'),
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
        itemCount: breweries.length,
        itemBuilder: (context, index) {
          var brewery = breweries[index];
          return ListTile(
            tileColor: Colors.grey,
            title: Text(brewery['name']),
            subtitle: Text('${brewery['city']}, ${brewery['state_province']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BreweryDetailPage(brewery: brewery),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.brown,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.grey),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.grey),
            label: 'Logout',
          ),
        ],
        onTap: (int index) async {
          if (index == 0) {
            //
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
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

