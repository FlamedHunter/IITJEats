import 'package:flutter/material.dart';
import 'package:test_app/Accounts/CreateEditUsers/googlelogin.dart';

class CreateUserPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Center(
                child: Text(
                  'IITJ Eats',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "Enter Address for Future Delivery",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  hintText: "Enter your mobile number",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  // onPressed: () {
                  //   final user = createUser(
                  //       email: emailController.text,
                  //       address: addressController.text,
                  //       number: numberController.text);
                  //   user.createuser(user);
                  // },
                  onPressed: () async {
                    final user = createUser(
                        email: emailController.text,
                        address: addressController.text,
                        number: numberController.text);
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
                                Text("Creating account..."),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    try {
                      await user.createuser(user);
                      // Remove the progress indicator.
                      Navigator.pop(context);
                    } catch (error) {
                      // Remove the progress indicator.
                      Navigator.pop(context);
                      // Handle the error here.
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthServices().signOut(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
