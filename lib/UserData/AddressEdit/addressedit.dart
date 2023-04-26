import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<String?> fetchAddress(String userEmail) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('UserData')
      .where('email', isEqualTo: userEmail)
      .get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.data()['address'];
  } else {
    return null;
  }
}

Future<String> getDocumentId(String email) async {
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('UserData')
      .where('email', isEqualTo: email)
      .get();
  final List<DocumentSnapshot> documents = result.docs;
  if (documents.isNotEmpty) {
    // If there is a matching document, return its ID
    return documents.first.id;
  } else {
    // If there is no matching document, return null
    return '';
  }
}

void updateDocument(String documentid, String address) {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('UserData');
  DocumentReference docRef = collectionRef.doc(documentid);

  docRef.update({
    'address': address,
  });
}

class AddressEditPage extends StatefulWidget {
  const AddressEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<AddressEditPage> {
  final email = FirebaseAuth.instance.currentUser!.email!;
  String? _oldname; // change to nullable String
  String _newname = "";
  bool _isEditing = false;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAddress(email).then((value) {
      setState(() {
        _oldname = value;
        _textEditingController.text = _oldname ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Text(
          "Current Address",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _textEditingController,
              enabled: _isEditing,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                hintText: 'Enter the text',
              ),
              onChanged: (value) {
                setState(() {
                  _newname = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!_isEditing)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: Text('EDIT'),
                  ),
                if (_isEditing)
                  Row(
                    children: [
                      ElevatedButton(
                        // onPressed: () async {
                        //   setState(() {
                        //     _isEditing = false;
                        //     _oldname = _newname;
                        //   });
                        //   String documentId = await getDocumentId(email);
                        //   updateDocument(documentId, _newname);
                        // },
                        onPressed: () async {
                          // Show the circular progress indicator.
                          setState(() {
                            _isEditing = false;
                            _oldname = _newname;
                          });
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
                                      Text("Updating Address..."),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            String documentId = await getDocumentId(email);
                            // Remove the progress indicator.
                            Navigator.pop(context);
                            // Call the _incrementCounter() function.
                            updateDocument(documentId, _newname);
                          } catch (error) {
                            // Remove the progress indicator.
                            Navigator.pop(context);
                            // Handle the error here.
                          }
                        },
                        child: Text('SAVE'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                            _newname = _oldname ?? '';
                          });
                        },
                        child: Text('CANCEL'),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToAddressEdit(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddressEditPage()),
  );
}
