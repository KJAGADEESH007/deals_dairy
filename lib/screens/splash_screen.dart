import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInternet();
    Timer(Duration(seconds: 10), _navigateToNextScreen);
  }

  Future<void> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _hasInternet = false;
      });
    }
  }

  void _navigateToNextScreen() {
    if (_hasInternet) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please check your internet connection.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _checkInternet();
                },
                child: Text('Retry'),
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/background_image.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ],
          ),
          Visibility(
            visible: !_hasInternet,
            child: Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Text(
                    'No Internet Connection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !_hasInternet,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

