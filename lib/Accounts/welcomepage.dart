import 'package:flutter/material.dart';
import 'package:test_app/Accounts/CreateEditUsers/googlelogin.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
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
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  Text(
                    'One place to satisfy all your cravings',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: (){},
            //   child: ,
            // )
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextButton(
                onPressed: () {
                  AuthServices().signInWithGoogle();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Image(
                        image: AssetImage("assets/images/googlelogo.png"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Login with Google",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
