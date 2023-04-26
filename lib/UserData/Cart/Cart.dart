import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:test_app/Payments/Paymentpage.dart';
import 'package:test_app/UserData/Cart/CartEmptyPage.dart';
import 'package:test_app/UserData/CartUpdate/cartupdate.dart';

import '../CartUpdate/CartElements.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<String, dynamic> cartData = {};
  bool isLoading = false;
  Map<String, dynamic> itemprice = {};
  num totalsum = 0;

  @override
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

    if (cartData.docs.isNotEmpty) {
      var cartDataMap = cartData.docs.first.data();
      cartDataMap.remove('email');

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

  Widget _buildCartItemList() {
    if (isLoading) {
      return Center(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (cartData.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => const CartEmptyPage());
      });
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cartData.length,
      itemBuilder: (BuildContext context, int index) {
        var item = cartData.keys.toList()[index];
        var qty = cartData[item];

        return Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item,
                  style: TextStyle(),
                ),
                Row(
                  children: [
                    IconButton(
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
                                    Text("Updating cart..."),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        try {
                          await updateCart(item, 1);
                          // Remove the progress indicator.
                          Navigator.pop(context);
                          // Call the _incrementCounter() function.
                          // totalsum = totalsum + itemprice[item];
                          setState(
                            () {
                              cartData[item]++;
                            },
                          );
                        } catch (error) {
                          // Remove the progress indicator.
                          Navigator.pop(context);
                          // Handle the error here.
                        }
                        // await updateCart(item, 1);
                        // setState(
                        //   () {
                        //     cartData[item]++;
                        //   },
                        // );
                      },
                      icon: Icon(Icons.add),
                    ),
                    Text(
                      qty.toString(),
                      style: TextStyle(),
                    ),
                    IconButton(
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
                                    Text("Updating cart..."),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        try {
                          await updateCart(item, -1);
                          // Remove the progress indicator.
                          Navigator.pop(context);
                          // Call the _incrementCounter() function.
                          setState(
                            () {
                              cartData[item]--;
                              // totalsum = totalsum - itemprice[item];
                              if (cartData[item] <= 0) {
                                cartData.remove(item);
                              }
                            },
                          );
                        } catch (error) {
                          // Remove the progress indicator.
                          Navigator.pop(context);
                          // Handle the error here.
                        }
                        // await updateCart(item, -1);
                        // setState(
                        //   () {
                        //     cartData[item]--;
                        //     if (cartData[item] <= 0) {
                        //       cartData.remove(item);
                        //     }
                        //   },
                        // );
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _buildCartTotal() {
  //   // Section 2 implementation (cart total) goes here
  //   return Container(
  //     child: Card(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       child: Container(
  //         padding: EdgeInsets.all(15),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   "Item Total",
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 Text(
  //                   "Rs $totalsum",
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               height: 4,
  //             ),
  //             Divider(
  //               thickness: 1,
  //               color: Colors.grey,
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               height: 4,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   "Packing & Other Charges",
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 Text(
  //                   "Rs 0",
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               height: 4,
  //             ),
  //             Divider(
  //               thickness: 1,
  //               color: Colors.grey,
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               height: 4,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   "To Pay",
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 Text(
  //                   "Rs $totalsum",
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Text(
          "Items in Cart",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Items in Cart",
              //   style: TextStyle(
              //     fontSize: MediaQuery.of(context).size.width > 600 ? 40 : 22,
              //     color: Colors.blue,
              //   ),
              // ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    _buildCartItemList(),
                  ],
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
                  onPressed: () {
                    Get.to(
                      () => const PaymentPage(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 400),
                    );
                  },
                  child: Text(
                    "Proceed To Payment",
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
      ),
    );
  }
}
