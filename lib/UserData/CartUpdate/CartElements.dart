import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>> itemprices() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentUserEmail = currentUser!.email!;

  final cartRef = FirebaseFirestore.instance.collection('Cart');
  final cartDoc =
      await cartRef.where('email', isEqualTo: currentUserEmail).get();

  if (cartDoc.docs.isNotEmpty) {
    final cartData = Map<String, dynamic>.from(cartDoc.docs[0].data());
    cartData.remove('email');

    final canteenMenuRef = FirebaseFirestore.instance.collection('CanteenMenu');
    final canteenDocs = await canteenMenuRef.get();

    canteenDocs.docs.forEach(
      (doc) {
        doc.data().forEach(
          (key, value) {
            if (cartData.containsKey(key)) {
              cartData[key] = value;
            }
          },
        );
      },
    );
    return cartData;
  }

  // Return an empty map if cart document doesn't exist
  return {};
}
