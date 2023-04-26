import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> orderprepared(String documentId) async {
  // Get the document data from the original collection
  DocumentReference originalDocumentRef = FirebaseFirestore.instance
      .collection('CurrentCanteenOrders')
      .doc(documentId);
  DocumentSnapshot originalDocumentSnapshot = await originalDocumentRef.get();
  Map<String, dynamic>? originalData =
      originalDocumentSnapshot.data() as Map<String, dynamic>;

  if (originalData.isEmpty) {
    // Document does not exist in original collection
    return;
  }

  // Transfer the document data to the new collection

  CollectionReference newCollectionRef =
      FirebaseFirestore.instance.collection('PreparedOrders');
  await newCollectionRef.doc(documentId).set(originalData);

  final email = originalData['email'];
  final queSnapshot = await FirebaseFirestore.instance
      .collection('UserPendingOrders')
      .where('email', isEqualTo: email)
      .get();
  final docId = queSnapshot.docs.first.id;
  final docRef =
      FirebaseFirestore.instance.collection('UserPendingOrders').doc(docId);
  print(docRef);

  await docRef.update(
    {
      'status': 'Ready for Delivery',
    },
  );

  await originalDocumentRef.delete();
}

Future<void> ordercancelled(String documentId) async {
  // Get the document data from the original collection
  DocumentReference originalDocumentRef = FirebaseFirestore.instance
      .collection('CurrentCanteenOrders')
      .doc(documentId);
  DocumentSnapshot originalDocumentSnapshot = await originalDocumentRef.get();
  Map<String, dynamic>? originalData =
      originalDocumentSnapshot.data() as Map<String, dynamic>;

  if (originalData.isEmpty) {
    // Document does not exist in original collection
    return;
  }
  final email = originalData['email'];
  final queSnapshot = await FirebaseFirestore.instance
      .collection('UserPendingOrders')
      .where('email', isEqualTo: email)
      .get();
  final docId = queSnapshot.docs.first.id;
  final docRef =
      FirebaseFirestore.instance.collection('UserPendingOrders').doc(docId);
  print(docRef);

  await docRef.update(
    {
      'status': 'Cancelled',
    },
  );

  await originalDocumentRef.delete();
}

Future<void> orderdelivered(String documentId) async {
  // Get the document data from the original collection
  DocumentReference originalDocumentRef =
      FirebaseFirestore.instance.collection('PreparedOrders').doc(documentId);
  DocumentSnapshot originalDocumentSnapshot = await originalDocumentRef.get();
  Map<String, dynamic>? originalData =
      originalDocumentSnapshot.data() as Map<String, dynamic>;

  if (originalData.isEmpty) {
    // Document does not exist in original collection
    return;
  }

  // Transfer the document data to the new collection
  CollectionReference newCollectionRef =
      FirebaseFirestore.instance.collection('CanteenOrders');
  await newCollectionRef.doc(documentId).set(originalData);

  originalData.remove('username');
  // Remove the document data from the original collection
  CollectionReference neCollectionRef =
      FirebaseFirestore.instance.collection('UserOrders');
  await neCollectionRef.doc(documentId).set(originalData);

  final email = originalData['email'];
  final queSnapshot = await FirebaseFirestore.instance
      .collection('UserPendingOrders')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
  final docReference = queSnapshot.docs.first.reference;
  await docReference.delete();

  await originalDocumentRef.delete();
}
