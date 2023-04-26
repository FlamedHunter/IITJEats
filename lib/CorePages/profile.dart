import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Accounts/CreateEditUsers/googlelogin.dart';
import 'package:get/get.dart';
import 'package:test_app/Accounts/Pages/CreateUser.dart';
import 'package:test_app/HelpPages/ContactUsForm/ContactUs.dart';
import 'package:test_app/Orders/NoOrdersPage.dart';
import 'package:test_app/Orders/PastOrders.dart';
import 'package:test_app/Orders/pendingorders.dart';
import 'package:test_app/UserData/AddressEdit/addressedit.dart';
import 'package:test_app/UserData/Cart/Cart.dart';
import 'package:test_app/UserData/Cart/CartEmptyPage.dart';

import '../UserData/AddressEdit/numberedit.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Center(
          child: Text(
            "IITJ Eats",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName!,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 30
                                : 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 25 : 10,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
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
                          final c = await check();
                          if (c == 1) {
                            Get.to(() => const AddressEditPage())?.then(
                                (value) => Navigator.of(context)
                                    .popUntil((route) => route.isFirst));
                          } else {
                            Get.to(() => CreateUserPage())?.then((value) =>
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst));
                          }
                        } catch (error) {
                          // Remove the progress indicator.
                          Navigator.pop(context);
                          // Handle the error here.
                        }
                        // final c = await check();
                        // if (c == 1) {
                        //   navigateToAddressEdit(context);
                        // } else {
                        //   Get.to(() => CreateUserPage());
                        // }

                        // handle container click
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saved Addresses",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 30
                                        : 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Edit Address",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25
                                        : 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
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
                          final c = await check();
                          if (c == 1) {
                            Get.to(() => const NumberEditPage())?.then(
                                (value) => Navigator.of(context)
                                    .popUntil((route) => route.isFirst));
                          } else {
                            Get.to(() => CreateUserPage())?.then((value) =>
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst));
                          }
                        } catch (error) {
                          // Remove the progress indicator.
                          Navigator.pop(context);
                          // Handle the error here.
                        }
                        // final c = await check();
                        // if (c == 1) {
                        //   navigateToNumberEdit(context);
                        // } else {
                        //   Get.to(() => CreateUserPage());
                        // }

                        // handle container click
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mobile No.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 30
                                        : 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Edit mobile number",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25
                                        : 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const PendingOrders(),
                          transition: Transition.downToUp,
                          duration: Duration(milliseconds: 400),
                        );
                        // handle container click
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pending Orders",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 30
                                        : 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Orders being prepared",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25
                                        : 10,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
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
                                    CircularProgressIndicator(),
                                    SizedBox(width: 20.0),
                                    Text("Getting Data..."),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        try {
                          final snapshot = await FirebaseFirestore.instance
                              .collection('UserOrders')
                              .where('email',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.email!)
                              .get();
                          if (snapshot.docs.isEmpty) {
                            Get.to(() => const NoOrdersPage())?.then((value) =>
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst));
                          } else {
                            Get.to(() => const PastOrders())?.then((value) =>
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst));
                          }
                        } catch (error) {
                          // Remove the progress indicator.
                          Navigator.pop(context);
                          // Handle the error here.
                        }
                        // final snapshot = await FirebaseFirestore.instance
                        //     .collection('UserOrders')
                        //     .where('email',
                        //         isEqualTo:
                        //             FirebaseAuth.instance.currentUser!.email!)
                        //     .orderBy('timestamp', descending: true)
                        //     .snapshots();
                        // Get.to(
                        //   () => const PastOrders(),
                        //   transition: Transition.leftToRight,
                        //   duration: const Duration(milliseconds: 400),
                        // );
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Past Orders",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 30
                                        : 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Past order list",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25
                                        : 10,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
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
                                    CircularProgressIndicator(),
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
                          Navigator.pop(context);
                          // Handle the error here.
                        }
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 30
                                        : 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Add & remove items in cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25
                                        : 10,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ContactUs(),
                          transition: Transition.downToUp,
                          duration: Duration(milliseconds: 400),
                        );
                        // handle container click
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Help",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 30
                                        : 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "FAQs & Links",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25
                                        : 10,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        AuthServices().signOut(context);
                        // handle container click
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign out",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 30
                                        : 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Text(
                            //   "FAQs & Links",
                            //   style: TextStyle(
                            //     color: Colors.black,
                            //     fontSize: MediaQuery.of(context).size.width > 600
                            //         ? 25
                            //         : 10,
                            //     // fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

Future<bool> isCartDataPresent() async {
  final email = FirebaseAuth.instance.currentUser!.email!;
  var cartData = await FirebaseFirestore.instance
      .collection('Cart')
      .where('email', isEqualTo: email)
      .get();

  if (cartData.docs.isNotEmpty) {
    var cartDataMap = cartData.docs.first.data();
    cartDataMap.remove('email');
    if (cartDataMap.length > 0) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
