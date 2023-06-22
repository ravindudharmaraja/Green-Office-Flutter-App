import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset(
                      'assets/splashhd.png',
                      // height: 10,
                      width: 200,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Center(
                              child: Image.asset(
                                'assets/logo.png',
                                // height: 170,
                                width: 300,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Center(
                              child: Text(
                                'About Green Office',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'The "Green Office" app is an Android application designed to help offices reduce their environmental impact while streamlining data collection processes. The app provides an easy-to-use interface for electronic data entry and storage, eliminating the need for paper forms and records. "Geen Office" is an ideal solution for any business looking to reduce paper usage and simplify data collection.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Developed by:\nD.P.M.R.N Dharmaraja\nUndergraduate in SIBA Campus\nand Intern at Sri Lanka Telecom',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontFamily: 'Poppins',
                                      fontSize: 9,
                                    ),
                                  ),
                                  Text(
                                    'Supervised by:\nMr.P.K.W.N. Wishmewan\nExternal Channel Manager,\nSri Lanka Telecom',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontFamily: 'Poppins',
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            // Center(
                            //   child: ElevatedButton(
                            //     onPressed: () {},
                            //     style: ButtonStyle(
                            //       backgroundColor:
                            //           MaterialStateProperty.all<Color>(
                            //         Colors.green,
                            //       ),
                            //       shape: MaterialStateProperty.all<
                            //           RoundedRectangleBorder>(
                            //         RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(10.0),
                            //         ),
                            //       ),
                            //     ),
                            //     child: const Padding(
                            //       padding: EdgeInsets.symmetric(
                            //           vertical: 12.0, horizontal: 32.0),
                            //       //color

                            //       child: Text(
                            //         'Get Started',
                            //         style: TextStyle(
                            //           fontFamily: 'Poppins',
                            //           fontSize: 20,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 16),
                            // Center(
                            //   child: TextButton(
                            //     onPressed: () {},
                            //     child: Text(
                            //       'Learn More',
                            //       style: TextStyle(
                            //         color: Colors.grey[800],
                            //         fontFamily: 'Poppins',
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.bold,
                            //         decoration: TextDecoration.underline,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
