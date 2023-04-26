import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/CorePages/restaurants.dart';
import 'package:test_app/HelpPages/contact.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Section 1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          // child: Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/Section 1.jpg'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Section1(),
                  Section2(),
                  // Section3(),
                  const Section4(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Section1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/Section 1.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'IITJ Eats',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 80 : 40,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'FOOD FOR ALL',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'IITJ Eats',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? 45
                                  : 25,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                            width: double.infinity,
                          ),
                          Text(
                            'The Best Place to Satisfy Your Cravings',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? 35
                                  : 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => restaurant(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 400),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ContactUsPage(),
                        //   ),
                        // );
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 30 : 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFF8E8E8),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
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

class Section3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth * 1.2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GridView.count(
          crossAxisCount: (screenWidth < 600) ? 2 : 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: List.generate(
            8,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('assets/images/food$index.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Section4 extends StatelessWidget {
  const Section4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'IITJ Eats',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Contact us now to register your restaurant',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tel: 7528953704 \nemail: garg.25@iitj.ac.in',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
