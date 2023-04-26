import 'package:flutter/material.dart';
import 'package:test_app/CorePages/home.dart';
import 'package:test_app/Menu/Pages/CanteenMenu.dart';

class restaurant extends StatelessWidget {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(
            //   'IITJ Eats',
            //   style: TextStyle(
            //     fontSize: MediaQuery.of(context).size.width * 0.08,
            //     fontStyle: FontStyle.italic,
            //     color: Colors.blue,
            //   ),
            // ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CanteenMenu(collectionName: 'CanteenMenu'),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.2,
                      height: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.2,
                      margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/CanteenTitle.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.height * 0.06
                              : MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          "Canteen",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 35
                                : 25,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "4",
                              style: TextStyle(
                                fontSize: 18.5,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Night Canteen ...",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? 25
                                  : 15,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
