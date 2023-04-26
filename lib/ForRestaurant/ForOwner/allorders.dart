import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidgetBuilder extends StatefulWidget {
  @override
  State<MyWidgetBuilder> createState() => _MyWidgetBuilderState();
}

class _MyWidgetBuilderState extends State<MyWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('CanteenOrders')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        List<Widget> widgets = [];
        snapshot.data!.docs.forEach(
          (DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            String documentId = doc.id;
            final username = data['username'];
            final email = data['email'];
            final totalitems = data['totalitems'];
            final totalamount = data['totalamount'];
            data.remove('email');
            data.remove('username');
            data.remove('totalamount');
            data.remove('timestamp');
            data.remove('totalitems');
            // Build the container widget for this document
            Widget container = Card(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email: $email",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Total Items: $totalitems",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Total Price: $totalamount",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: data.entries.map(
                        (entry) {
                          return Row(
                            children: [
                              Text(
                                '${entry.key}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '${entry.value}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            );

            // Add the container widget to the list of widgets
            widgets.add(container);
          },
        );

        return Column(children: widgets);
      },
    );
  }
}

class AllPastCateenOrders extends StatelessWidget {
  const AllPastCateenOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Center(
          child: Text(
            "IITJ Eats",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: MyWidgetBuilder(),
      ),
    );
  }
}
