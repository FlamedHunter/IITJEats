import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Accounts/CreateEditUsers/googlelogin.dart';
import 'package:test_app/ForRestaurant/ForOwner/CanteenStatus.dart';
import 'package:test_app/ForRestaurant/ForOwner/allorders.dart';
import 'package:test_app/ForRestaurant/ForOwner/orders.dart';
import 'package:test_app/ForRestaurant/ForOwner/restaurantopening.dart';
import 'package:test_app/ForRestaurant/ordersready.dart';

class Restauranthomepage extends StatefulWidget {
  const Restauranthomepage({super.key});

  @override
  State<Restauranthomepage> createState() => _RestauranthomepageState();
}

class _RestauranthomepageState extends State<Restauranthomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Text(
          "IITJ Eats",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/CanteenHomePage.avif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CanteenStatusPage(),
                          transition: Transition.leftToRightWithFade,
                          duration: Duration(milliseconds: 400));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Check Canteen Status",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ShowOrders(),
                          transition: Transition.leftToRightWithFade,
                          duration: Duration(milliseconds: 400));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Orders Being Prepared",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ShowOrdersForDelivery(),
                          transition: Transition.leftToRightWithFade,
                          duration: Duration(milliseconds: 400));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Orders Ready For Delivery",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AllPastCateenOrders(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 400));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "All Past Orders",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AuthServices().signOut(context);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
