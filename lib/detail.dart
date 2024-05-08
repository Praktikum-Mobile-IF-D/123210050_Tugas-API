import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BreweryDetailPage extends StatelessWidget {
  final Map<String, dynamic> brewery;

  BreweryDetailPage({required this.brewery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewery Detail'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(16.0),
        child: Card(
          color: Colors.grey[400],
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    brewery['name'],
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text('Type: ${brewery['brewery_type']}'),
                Text('Address: ${brewery['address_1']}'),
                Text('City: ${brewery['city']}'),
                Text('State: ${brewery['state_province']}'),
                Text('Postal Code: ${brewery['postal_code']}'),
                Text('Country: ${brewery['country']}'),
                Text('Phone: ${brewery['phone']}'),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _launchURL(brewery['website_url']);
                    },
                    child: Text('Visit Website', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
