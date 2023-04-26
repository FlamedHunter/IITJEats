import 'package:flutter/material.dart';
import 'package:test_app/ForRestaurant/ForOwner/restaurantopening.dart';

class CanteenStatusPage extends StatefulWidget {
  @override
  _CanteenStatusPageState createState() => _CanteenStatusPageState();
}

class _CanteenStatusPageState extends State<CanteenStatusPage> {
  bool _isTeenEnclosed = false;
  late String _text1;
  late String _text2;

  @override
  void initState() {
    super.initState();
    _checkIsTeenEnclosed();
  }

  Future<void> _checkIsTeenEnclosed() async {
    bool result = await iscanteenclosed();
    setState(() {
      _isTeenEnclosed = result;
      _text1 = result
          ? 'Canteen is currently closed'
          : 'Canteen is open and accepting orders';
      _text2 = result
          ? 'Tap to stop accepting orders'
          : 'Tap to stop accepting orders';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: iscanteenclosed(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isTeenEnclosed = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Color.fromARGB(255, 205, 188, 174),
              title: Center(
                child: Text(
                  "IITJ Eats",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _text1,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      decorationThickness: 0,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
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
                        await updatecanteenstatus();
                        // Remove the progress indicator.
                        Navigator.pop(context);
                        _checkIsTeenEnclosed();
                        setState(() {});
                      } catch (error) {
                        // Remove the progress indicator.
                        Navigator.pop(context);
                      }
                    },
                    child: Text(_text2),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 210, 161, 240),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width > 600
                        ? MediaQuery.of(context).size.height * 0.4
                        : MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/waiting.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
