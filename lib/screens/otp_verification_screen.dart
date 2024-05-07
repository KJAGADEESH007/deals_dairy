import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OtpVerificationScreen({required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int _secondsLeft = 120;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_secondsLeft == 0) {
          timer.cancel();
        } else {
          _secondsLeft--;
        }
      });
    });
  }

  void _resendOtp() async {
    // API request for resending OTP
    final response = await http.post(
      Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp/verification'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': '9879', // Replace with actual OTP value
        'deviceId': '62b43472c84bb6dac82e0504',
        'userId': '62b43547c84bb6dac82e0525',
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful OTP resend
    } else {
      // Handle OTP resend failure
    }

    setState(() {
      _secondsLeft = 120; // Reset timer
    });
    _startTimer();
  }

  void _verifyOtp() async {
    // Construct the request body
    Map<String, dynamic> requestBody = {
      'otp': '9879', // Replace with the actual OTP value entered by the user
      'deviceId': '62b43472c84bb6dac82e0504',
      'userId': '62b43547c84bb6dac82e0525',
    };

    // Convert the request body to JSON format
    String requestBodyJson = jsonEncode(requestBody);

    // Send the OTP verification request
    final response = await http.post(
      Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp/verification'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      // OTP verification successful, navigate to home screen
      Navigator.pop(context); // Pop OTP verification screen
      // Navigate to home screen
    } else {
      // Handle OTP verification failure
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to verify OTP. Please try again.'),
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
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/mobile_icon.jpeg',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Text(
              'OTP Verification Screen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'An OTP has been sent to',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              widget.phoneNumber,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpBox(),
                SizedBox(width: 10),
                OtpBox(),
                SizedBox(width: 10),
                OtpBox(),
                SizedBox(width: 10),
                OtpBox(),
              ],
            ),
            SizedBox(height: 20),
            _secondsLeft == 0
                ? TextButton(
              onPressed: _resendOtp,
              child: Text('Send Again'),
            )
                : Text(
              'Resend in $_secondsLeft seconds',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counter: Offstage(),
        ),
      ),
    );
  }
}
