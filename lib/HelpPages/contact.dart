// import 'package:flutter/material.dart';

// class ContactUsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Contact Us',
//                 style: TextStyle(
//                   fontSize: MediaQuery.of(context).size.width * 0.1,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Name',
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         maxLines: 6,
//                         decoration: InputDecoration(
//                           labelText: 'Description of the Issue Faced',
//                         ),
//                       ),
//                       SizedBox(height: 32),
//                       TextFormField(
//                         maxLines: 6,
//                         decoration: InputDecoration(
//                           labelText: 'Suggestions for Improvement',
//                         ),
//                       ),
//                       SizedBox(height: 32),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text('Submit'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/main.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController name_cont = TextEditingController();
    final TextEditingController email_cont = TextEditingController();
    final TextEditingController phone_cont = TextEditingController();
    final TextEditingController msg_cont = TextEditingController();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pic4.jpg"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset("assets/images/pic1.jpg")),
                        ),
                        ColoredBox(
                          color: Colors.blueAccent,
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter Your Name*",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextField(
                                    controller: name_cont,
                                    decoration:
                                        InputDecoration(hintText: "First Name"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Enter Your Email*",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextField(
                                    controller: email_cont,
                                    decoration:
                                        InputDecoration(hintText: "Email"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Enter Your Phone",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextField(
                                    controller: phone_cont,
                                    decoration:
                                        InputDecoration(hintText: "Phone"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Enter Your Message",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextField(
                                    controller: msg_cont,
                                    decoration:
                                        InputDecoration(hintText: "Message"),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> data = {
                            "Name": name_cont.text,
                            "EmailID": email_cont.text,
                            "Phone No.": phone_cont.text,
                            "Message": msg_cont.text,
                          };
                          await FirebaseFirestore.instance
                              .collection("Feedback")
                              .add(data);
                          Get.snackbar("Success", "Form submitted Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.withOpacity(0.1),
                              colorText: Colors.green);
                          Get.offAll(() => MainScreen());
                        },
                        child: Text("Submit"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
