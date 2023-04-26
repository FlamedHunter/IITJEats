import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/CorePages/profile.dart';
import 'package:test_app/Menu/MenuData/FetchMenu.dart';
import 'package:test_app/UserData/CartUpdate/cartupdate.dart';

import '../../UserData/Cart/Cart.dart';
import '../../UserData/Cart/CartEmptyPage.dart';

class CanteenMenu extends StatefulWidget {
  final String collectionName;

  const CanteenMenu({Key? key, required this.collectionName}) : super(key: key);

  @override
  _CanteenMenuState createState() => _CanteenMenuState();
}

class _CanteenMenuState extends State<CanteenMenu> {
  late List<Map<String, dynamic>> _data = [];
  Map<String, int> _counterMap = {};
  final bool _isCartVisible = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    MenuDataFetcher fetcher = MenuDataFetcher(widget.collectionName);
    List<Map<String, dynamic>> data = await fetcher.fetch();
    setState(
      () {
        _data = data;
      },
    );
  }

  void _incrementCounter(String field) {
    setState(() {
      if (_counterMap.containsKey(field)) {
        _counterMap[field] = _counterMap[field]! + 1;
      } else {
        _counterMap[field] = 1;
      }
    });
  }

  void _decrementCounter(String field) {
    setState(() {
      if (_counterMap.containsKey(field)) {
        if (_counterMap[field]! > 0) {
          _counterMap[field] = _counterMap[field]! - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        title: Text(
          "Canteen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/CanteenTitle.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  // String field = _data[index].keys.first;
                  // dynamic value = _data[index].values.first;
                  Map<String, dynamic> item = _data[index];
                  List<Widget> fieldWidgets = [];
                  // int counter =
                  //     _counterMap.containsKey(field) ? _counterMap[field]! : 0;
                  item.forEach(
                    (key, value) {
                      int counter =
                          _counterMap.containsKey(key) ? _counterMap[key]! : 0;

                      fieldWidgets.add(
                        Card(
                          color: Color.fromARGB(255, 255, 239, 216),
                          child: GestureDetector(
                            onTap: () async {
                              // Show the circular progress indicator.
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
                                          Text("Updating cart..."),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );

                              try {
                                await updateCart(key, 1);
                                // Remove the progress indicator.
                                Navigator.pop(context);
                                // Call the _incrementCounter() function.
                                _incrementCounter(key);
                              } catch (error) {
                                // Remove the progress indicator.
                                Navigator.pop(context);
                                // Handle the error here.
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$key',
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 40
                                              : 20,
                                    ),
                                  ),
                                  counter == 0
                                      ? Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Rs $value',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            IconButton(
                                              // onPressed: () async {
                                              //   await updateCart(key, -1);
                                              //   _decrementCounter(key);
                                              // },
                                              onPressed: () async {
                                                // Show the circular progress indicator.
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            20.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            CircularProgressIndicator(),
                                                            SizedBox(
                                                                width: 20.0),
                                                            Text(
                                                                "Updating cart..."),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                                try {
                                                  await updateCart(key, -1);
                                                  // Remove the progress indicator.
                                                  Navigator.pop(context);
                                                  // Call the _decrementCounter() function.
                                                  _decrementCounter(key);
                                                } catch (error) {
                                                  // Remove the progress indicator.
                                                  Navigator.pop(context);
                                                  // Handle the error here.
                                                }
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                            Text(
                                              '$counter',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              // onPressed: () async {
                                              //   await updateCart(key, 1);
                                              //   _incrementCounter(key);
                                              // },
                                              onPressed: () async {
                                                // Show the circular progress indicator.
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            20.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            CircularProgressIndicator(),
                                                            SizedBox(
                                                                width: 20.0),
                                                            Text(
                                                                "Updating cart..."),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                                try {
                                                  await updateCart(key, 1);
                                                  // Remove the progress indicator.
                                                  Navigator.pop(context);
                                                  // Call the _incrementCounter() function.
                                                  _incrementCounter(key);
                                                } catch (error) {
                                                  // Remove the progress indicator.
                                                  Navigator.pop(context);
                                                  // Handle the error here.
                                                }
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  return Column(
                    children: fieldWidgets,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _isCartVisible
          ? FloatingActionButton(
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
                            const CircularProgressIndicator(),
                            SizedBox(width: 20.0),
                            Text("Loading..."),
                          ],
                        ),
                      ),
                    );
                  },
                );

                try {
                  bool isCartPresent = await isCartDataPresent();
                  if (isCartPresent) {
                    Get.to(() => const Cart())?.then((value) =>
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst));
                  } else {
                    Get.to(() => const CartEmptyPage())?.then((value) =>
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst));
                  }
                } catch (error) {
                  // Remove the progress indicator.
                  Navigator.pop(context);
                  // Handle the error here.
                }
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.blue,
              ),
            )
          : null,
    );
  }
}
