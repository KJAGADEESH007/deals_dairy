import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu icon tap
          },
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                ),
                items: [
                  'assets/images/slideimage1.jpg',
                  'assets/images/slideimage2.jpg',
                  'assets/images/slideimage3.jpg',
                ].map((imagePath) {
                  return Container(
                    height: 150,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10,),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'KYC Pending',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You need to provide the required documents for your account activation.',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        //
                      },
                      child: Text(
                        'Click here',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/camera.png', width: 50, height: 50),
                    Image.asset('assets/images/laptop.png', width: 50, height: 50),
                    Image.asset('assets/images/mobileicon.png', width: 50, height: 50),
                    Image.asset('assets/images/led.png', width: 50, height: 50),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle image tap
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/mobilephoneimage${index + 1}.png',),
                          fit:BoxFit.contain
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height:15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Deals'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
