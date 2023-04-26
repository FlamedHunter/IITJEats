import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:test_app/CorePages/restaurants.dart';
import 'package:test_app/main.dart';

class CartEmptyPage extends StatelessWidget {
  const CartEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => MainScreen());
        return true;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image(image: image),
              Text(
                "Good Food is Waiting for YOU",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 40 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Order Now",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 40 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                "Your Cart it empty.",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 30 : 15,
                  color: Colors.grey,
                ),
              ),
              Text(
                "Add something from the Menu",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 30 : 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => restaurant(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 400));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => restaurant()),
                  // );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 119, 189, 247),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Browse Restaurants",
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 600 ? 40 : 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
