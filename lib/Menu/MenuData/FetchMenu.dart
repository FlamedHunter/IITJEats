import 'package:cloud_firestore/cloud_firestore.dart';

class MenuDataFetcher {
  final String collectionName;

  MenuDataFetcher(this.collectionName);

  Future<List<Map<String, dynamic>>> fetch() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
