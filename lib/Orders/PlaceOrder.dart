import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:test_app/UserData/Cart/CartEmptyPage.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> placeOrder(num totalAmount) async {
  try {
    final userEmail = FirebaseAuth.instance.currentUser!.email!;
    final cartSnapshot = await FirebaseFirestore.instance
        .collection('Cart')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    if (cartSnapshot.docs.isEmpty) {
      return Get.offAll(() => const CartEmptyPage());
    }

    final cartData = cartSnapshot.docs.first.data();
    final items = Map<String, dynamic>.from(cartData)..remove('email');

    await FirebaseFirestore.instance.collection('UserPendingOrders').add(
      {
        ...items,
        'totalitems': items.length,
        'totalamount': totalAmount,
        'email': userEmail,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'status': 'Cooking',
      },
    );
    await FirebaseFirestore.instance.collection('CurrentCanteenOrders').add(
      {
        ...items,
        'totalitems': items.length,
        'totalamount': totalAmount,
        'email': userEmail,
        'username': FirebaseAuth.instance.currentUser!.displayName!,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );

    // Delete cart document
    await cartSnapshot.docs.first.reference.delete();
  } catch (e) {
    print('Error moving cart to orders: $e');
  }
}
