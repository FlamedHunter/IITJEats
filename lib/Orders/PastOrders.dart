import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPastOrders extends StatelessWidget {
  const GetPastOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('UserOrders')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email!)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Dialog(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20.0),
                    Text("Loading..."),
                  ],
                ),
              ),
            ),
          );
          ;
        }

        List<Widget> widgets = [];
        snapshot.data!.docs.forEach((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data.remove('email');
          final totalamount = data['totalamount'];
          final totalitems = data['totalitems'];
          data.remove('totalamount');
          data.remove('totalitems');
          data.remove('timestamp');
          // Build the container widget for this document
          Widget container = Container(
            height: MediaQuery.of(context).size.height * 0.2,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colros.)
            // ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Canteen",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rs $totalamount',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Delivered",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: data.entries.map(
                      (entry) {
                        return Row(
                          children: [
                            Text(
                              '${entry.key}(${entry.value})',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            // Text('${entry.value}'),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Total Items: $totalitems',
                  style: TextStyle(fontSize: 14),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ],
            ),
          );

          // Add the container widget to the list of widgets
          widgets.add(container);
        });

        return Column(children: widgets);
      },
    );
  }
}

class PastOrders extends StatelessWidget {
  const PastOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Text(
          "Past Orders",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetPastOrders(),
      ),
    );
  }
}
