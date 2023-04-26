import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/ForRestaurant/ForOwner/orderfunctions.dart';

class MyWidgetBuilder extends StatefulWidget {
  @override
  State<MyWidgetBuilder> createState() => _MyWidgetBuilderState();
}

class _MyWidgetBuilderState extends State<MyWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('CurrentCanteenOrders')
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
        snapshot.data!.docs.forEach((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String documentId = doc.id;
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
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
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
                                      Text("Updating..."),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            await orderprepared(documentId);
                            // Remove the progress indicator.
                            Navigator.pop(context);

                            setState(() {});
                          } catch (error) {
                            // Remove the progress indicator.
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Order Prepared",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
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
                                      Text("Cancelling Order..."),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            await ordercancelled(documentId);
                            // Remove the progress indicator.
                            Navigator.pop(context);

                            setState(() {});
                          } catch (error) {
                            // Remove the progress indicator.
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Cancel Order",
                        ),
                      )
                    ],
                  )
                ],
              ),
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

class ShowOrders extends StatelessWidget {
  const ShowOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Text(
          "Pending Orders",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: MyWidgetBuilder(),
      ),
    );
  }
}
