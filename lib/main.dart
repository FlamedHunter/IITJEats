import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Accounts/CreateEditUsers/googlelogin.dart';

import 'package:test_app/CorePages/home.dart';
import 'package:get/get.dart';

import 'package:test_app/UserData/Cart/Cart.dart';
import 'package:test_app/UserData/Cart/CartEmptyPage.dart';

import 'CorePages/restaurants.dart';
import 'CorePages/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IITJ Eats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthServices().handleAuthState(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    restaurant(),
    ProfilePage(),
  ];

  final bool _isCartVisible = true; // Change this based on cart state

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _isCartVisible
          ? FloatingActionButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(),
                            SizedBox(width: 20.0),
                            Text("Loading..."),
                          ],
                        ),
                      ),
                    );
                  },
                );

                try {
                  bool isCartPresent = await isCartDataPresent();
                  if (isCartPresent) {
                    Get.to(() => const Cart())?.then((value) =>
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst));
                  } else {
                    Get.to(() => const CartEmptyPage())?.then((value) =>
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst));
                  }
                } catch (error) {
                  // Remove the progress indicator.
                  Navigator.pop(context); // Handle the error here.
                }
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.blue,
              ),
            )
          : null,
    );
  }
}
