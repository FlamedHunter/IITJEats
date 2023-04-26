import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getDocumentId() async {
  final email = FirebaseAuth.instance.currentUser!.email!;
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('Cart')
      .where('email', isEqualTo: email)
      .get();
  final List<DocumentSnapshot> documents = result.docs;
  if (documents.isNotEmpty) {
    // If there is a matching document, return its ID
    return documents.first.id;
  } else {
    // If there is no matching document, return null
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Cart');
    DocumentReference documentRef = await collectionRef.add({
      'email': FirebaseAuth.instance.currentUser!.email!,
    });
    String documentId = documentRef.id;
    return documentId;
  }
}

Future<void> updateCart(String item, int value) async {
  final String documentId = await getDocumentId();
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('Cart');
  DocumentReference docRef = collectionRef.doc(documentId);

  docRef.get().then((snapshot) {
    if (snapshot.exists) {
      // Document already exists, check if item field exists and has a value
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      if (data.containsKey(item)) {
        int currentValue = data[item];
        if (currentValue + value <= 0) {
          // If the updated value is less than or equal to 0, delete the field
          docRef.update({
            item: FieldValue.delete(),
          });
        } else {
          // If the updated value is greater than 0, update the field with the new value
          docRef.update({
            item: currentValue + value,
          });
        }
      } else {
        // If item field does not exist, add it with a value of 1
        docRef.update({
          item: 1,
        });
      }
    } else {
      // Document does not exist, add item field with a value of 1
      docRef.set({
        item: 1,
      });
    }
  });
}
