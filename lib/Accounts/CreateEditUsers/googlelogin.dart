import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/Accounts/Pages/CreateUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:test_app/Accounts/welcomepage.dart';
import 'package:test_app/ForRestaurant/MainPage.dart';
import 'package:test_app/UserData/Cart/Cart.dart';
import 'package:test_app/main.dart';

final _db = FirebaseFirestore.instance;

class createUser {
  final String? id;
  final String address;
  final String email;
  final String number;
  final int pendingOrders = 0;
  final int ordersPlaced = 0;
  const createUser({
    this.id,
    required this.email,
    required this.address,
    required this.number,
  });

  toJson() {
    return {
      "address": address,
      "email": email,
      "number": number,
      "pendingOrders": pendingOrders,
      "ordersPlaced": ordersPlaced,
    };
  }

  createuser(createUser user) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.email == user.email) {
      try {
        await _db.collection("UserData").add(user.toJson());
        Get.snackbar("Success", "Your account has been created successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
        Get.offAll(() => MainScreen());
      } catch (error) {
        Get.snackbar("Error", "Something went wrong, please try again.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        print(error.toString());
        Get.to(() => CreateUserPage());
      }
    } else {
      Get.snackbar(
        "Error",
        "Please use the same email that you used to login with Google.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}

Future<int> check() async {
  try {
    final email = FirebaseAuth.instance.currentUser!.email!;
    final userdata = await FirebaseFirestore.instance
        .collection("UserData")
        .where("email", isEqualTo: email)
        .get();
    if (userdata.docs.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  } catch (error) {
    print("Error in check(): ${error.toString()}");
    return 0;
  }
}

class AuthServices {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a circular progress indicator while waiting for auth state to change
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          if (FirebaseAuth.instance.currentUser!.email! ==
              'samyakvh@gmail.com') {
            return const Restauranthomepage();
          } else {
            return MainScreen();
          }
        } else {
          return const WelcomePage();
        }
      },
    );
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>['email']).signIn();
      if (googleUser == null) {
        // User cancelled the sign-in process

        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      if (e is PlatformException) {
        // Handle sign-in errors such as user cancelling the sign-in process
        if (e.code == 'sign_in_canceled') {
          print('User cancelled the sign-in process');
          return null;
        }
      }
      print('Error signing in with Google: $e');
      return null;
    }
  }

  signOut(BuildContext context) async {
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
                Text("Logging Out..."),
              ],
            ),
          ),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      await GoogleSignIn().disconnect();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
