import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import 'otp_verification_screen.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _tabIconIndexSelected = 0; // Define _tabIconIndexSelected here
  String _loginOption = "phone";
  String _phoneNumber = "";
  String _email = "";
  bool _isLoading = false;

  void _sendCode() async {
    setState(() {
      _isLoading = true;
    });
    // API request
    final response = await http.post(
      Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        _loginOption == "phone" ? 'mobileNumber' : 'email': _loginOption == "phone" ? _phoneNumber : _email,
        'deviceId': '62b341aeb0ab5ebe28a758a3',
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpVerificationScreen(phoneNumber: _phoneNumber.isNotEmpty ? _phoneNumber : _email)),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send code. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset('assets/images/logo.jpg'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterToggleTab(
              width: 40,
              borderRadius: 15,
              selectedBackgroundColors: [Colors.red ],
              selectedIndex: _tabIconIndexSelected,
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              unSelectedTextStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labels: ["Phone", "Email"],
              selectedLabelIndex: (index) {
                setState(() {
                  _tabIconIndexSelected = index;
                  _loginOption = index == 0 ? "phone" : "email";
                });
              },
              marginSelected: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: _loginOption == "phone" ? 'Enter Phone Number' : 'Enter Email',
              ),
              onChanged: (value) {
                setState(() {
                  _loginOption == "phone" ? _phoneNumber = value : _email = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendCode,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: Text('Send Code'),
            ),
          ],
        ),
      ),
    );
  }
}
