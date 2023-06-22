// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/hidden_drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _officerNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _serviceNumberController = TextEditingController();

  @override
  void dispose() {
    _officerNameController.dispose();
    _positionController.dispose();
    _serviceNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadOfficerInfo();
  }

  Future<void> _loadOfficerInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _officerNameController.text = prefs.getString('officerName') ?? '';
      _positionController.text = prefs.getString('position') ?? '';
      _serviceNumberController.text = prefs.getString('serviceNumber') ?? '';
    });
  }

  Future<void> _saveOfficerInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('officerName', _officerNameController.text);
    await prefs.setString('position', _positionController.text);
    await prefs.setString('serviceNumber', _serviceNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Center(child: Text('Officer Information')),
        backgroundColor: const Color.fromARGB(
            255, 169, 216, 255), // Set the background color to blue
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.fitHeight,
              ), // Add image with opacity
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/avatar.png',
                            height: 120,
                            width: 120,
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _officerNameController,
                          decoration: const InputDecoration(
                            labelText: "CSU Officer Name",
                            filled: true,
                            fillColor: Color.fromARGB(147, 255, 255, 255),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter CSU officer name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _positionController,
                          decoration: const InputDecoration(
                            labelText: "CSU Officer Position",
                            filled: true,
                            fillColor: Color.fromARGB(147, 255, 255, 255),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _serviceNumberController,
                          decoration: const InputDecoration(
                            labelText: "CSU Officer Service No.",
                            filled: true,
                            fillColor: Color.fromARGB(147, 255, 255, 255),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter CSU officer service number";
                            } else if (value.length != 6) {
                              return "CSU officer service number must be 06 digits";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     //TODO: Implement save button functionality
                        //   },
                        //   child: Text(
                        //     "Save",
                        //     style: TextStyle(fontSize: 18),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                        //   ),
                        // ),
                        ElevatedButton(
                          onPressed: () async {
                            await _saveOfficerInfo();
                            final snackBar = const SnackBar(
                              content: Text(
                                  'Officer information was saved successfully!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HiddenDrawer(
                                    decoration: BoxDecoration()),
                              ),
                            );
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 12),
                          ),
                        ),
                        SizedBox(
                          height: 500,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // children: [
            //   Expanded(
            //     child: Stack(children: [
            //       Positioned.fill(
            //         child: Opacity(
            //           opacity: 0.5,
            //           child:
            //               Image.asset('assets/background.jpg', fit: BoxFit.cover),
            //         ),
            //       ),
            //     ]),
            //   ),
            // ],
          ),
        ],
      ),
    );
  }
}
