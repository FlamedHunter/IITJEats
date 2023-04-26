import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> iscanteenclosed() async {
  final collectionRef = FirebaseFirestore.instance.collection('CanteenData');

  final querySnapshot = await collectionRef.limit(1).get();

  if (querySnapshot.docs.isNotEmpty) {
    final docSnapshot = querySnapshot.docs.first;
    final field = docSnapshot['checkopen&close'];

    if (field == true) {
      return field;
    } else {
      return false;
    }
  }

  return false;
}

Future<void> updatecanteenstatus() async {
  final collectionRef = FirebaseFirestore.instance.collection('CanteenData');
  final querySnapshot = await collectionRef.limit(1).get();

  if (querySnapshot.docs.isNotEmpty) {
    final docSnapshot = querySnapshot.docs.first;
    final docRef = collectionRef.doc(docSnapshot.id);
    final field = docSnapshot['checkopen&close'];
    if (field == true) {
      await docRef.update({'checkopen&close': false});
    } else {
      await docRef.update({'checkopen&close': true});
    }

    // print('Field updated successfully.');
  } else {
    // print('No documents found.');
  }
}
