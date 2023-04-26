import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Orders/PlaceOrder.dart';
import '../UserData/Cart/CartEmptyPage.dart';
import '../UserData/CartUpdate/CartElements.dart';
import '../main.dart';
import 'package:firebase_database/firebase_database.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic> itemprice = {};
  Map<String, dynamic> cartData = {};
  num totalsum = 0;
  bool isLoading = false;
  void initState() {
    super.initState();
    _getCartData();
  }

  Future<void> _getCartData() async {
    setState(
      () {
        isLoading = true;
      },
    );
    final email = FirebaseAuth.instance.currentUser!.email!;
    var cartData = await FirebaseFirestore.instance
        .collection('Cart')
        .where('email', isEqualTo: email)
        .get();
    final itemprice = await itemprices();

    if (cartData.docs.isNotEmpty) {
      var cartDataMap = cartData.docs.first.data();
      cartDataMap.remove('email');

      cartDataMap.forEach(
        (key, value) {
          if (itemprice.containsKey(key)) {
            totalsum = totalsum + value * itemprice[key];
          }
        },
      );
      setState(
        () {
          this.cartData = cartDataMap;
          isLoading = false;
        },
      );
    } else {
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (cartData.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Get.offAll(() => const CartEmptyPage());
        },
      );
    }
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => MainScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Color.fromARGB(255, 220, 239, 255),
          title: Text(
            "Total Charge",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Item Total",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Rs $totalsum",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 4,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Packing & Other Charges",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Rs 0",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 4,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "To Pay",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Rs $totalsum",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: ElevatedButton(
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
                              CircularProgressIndicator(),
                              SizedBox(width: 20.0),
                              Text("Placing Order..."),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  try {
                    await placeOrder(totalsum);
                    // Remove the progress indicator.
                    Navigator.pop(context);
                    Get.snackbar("Success", "Your Order has been placed",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.withOpacity(0.1),
                        colorText: Colors.green);

                    Get.offAll(() => MainScreen());
                  } catch (error) {
                    // Remove the progress indicator.
                    Navigator.pop(context);
                    Get.snackbar("Failed", "An error occured please try again",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        colorText: Colors.red);
                    // Handle the error here.
                  }
                },
                child: Text(
                  "Pay & Place Order",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
