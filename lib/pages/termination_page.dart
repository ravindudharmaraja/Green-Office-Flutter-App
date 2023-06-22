// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, constant_identifier_names, use_build_context_synchronously
import 'dart:io';
import 'package:flutter_application_1/hidden_drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'dart:ui' as ui;
import 'package:flutter_application_1/Sheets/termination_sheets_api.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_application_1/pdf/mobile.dart'
    if (dart.library.html) 'package:flutter_application_1/pdf/web.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TerminationPage extends StatefulWidget {
  const TerminationPage({super.key});

  @override
  State<TerminationPage> createState() => _TerminationPageState();
}

class _TerminationPageState extends State<TerminationPage> {
  int currentStep = 0;
  bool isCompleted = false;
  final formKey = GlobalKey<FormState>();
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  TextEditingController cumtomerNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController NICNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController CSUDetailsController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController CSUNoteController = TextEditingController();
  // TextEditingController CSUOfficerServiceNoController = TextEditingController();
  TextEditingController CollectedCPENoteController = TextEditingController();
  // TextEditingController CSUOfficerNameController = TextEditingController();

  final CSUOfficerNameController = TextEditingController();
  final CSUOfficerServiceNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedOfficerInfo();
  }

  Future<void> _loadSavedOfficerInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String officerName = prefs.getString('officerName') ?? '';
    String serviceNo = prefs.getString('serviceNumber') ?? '';
    setState(() {
      CSUOfficerServiceNoController.text = serviceNo;
      CSUOfficerNameController.text = officerName;
    });
  }

  Widget controlsBuilder(context, details) {
    final isLastStep = currentStep == 2;
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
            )),
            const SizedBox(width: 20),
            if (currentStep != 0)
              Expanded(
                  child: OutlinedButton(
                onPressed: details.onStepCancel,
                child: const Text('BACK'),
              ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 247, 244),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child:
                      Image.asset('assets/background.jpg', fit: BoxFit.cover),
                ),
              ),
              Stepper(
                type: StepperType.vertical,
                steps: getSteps(),
                currentStep: currentStep,
                onStepContinue: () {
                  final isLastStep = currentStep == getSteps().length - 1;

                  if (!formKeys[currentStep].currentState!.validate()) return;

                  if (currentStep < (getSteps().length - 1)) {
                    setState(() => currentStep += 1);
                  }
                  if (isLastStep) {
                    final feedback = {
                      SheetsColumn.Customer_Name:
                          cumtomerNameController.text.trim(),
                      SheetsColumn.Account_Number:
                          accountNumberController.text.trim(),
                      SheetsColumn.Phone_Number:
                          phoneNumberController.text.trim(),
                      SheetsColumn.NIC_Number: NICNumberController.text.trim(),
                      SheetsColumn.Mobile_Number:
                          mobileNumberController.text.trim(),
                      SheetsColumn.Reason: reasonController.text.trim(),
                      SheetsColumn.CSU_Note: CSUNoteController.text.trim(),
                      SheetsColumn.Collected_CPE_Note:
                          CollectedCPENoteController.text.trim(),
                      SheetsColumn.CSU_Officer_ServiceNo:
                          CSUOfficerServiceNoController.text.trim(),
                      SheetsColumn.CSU_Officer_Name:
                          CSUOfficerNameController.text.trim(),
                    };

                    Termination.insert([feedback]);
                  }

                  if (isLastStep) {
                    _CreatePDF();
                  }

                  if (isLastStep) {
                    alert();
                  }
                },
                onStepTapped: (step) => setState(() => currentStep = step),
                onStepCancel: () {
                  final isFirstStep = currentStep == 0;

                  if (isFirstStep) {
                    currentStep >= 0 ? null : setState(() => currentStep -= 1);
                  } else {
                    setState(() => currentStep -= 1);
                  }
                },
                controlsBuilder: controlsBuilder,
              ),
            ],
          ))
        ]));
  }

  getSteps() => [
        Step(
          title: const Text('Customer Details'),
          content: Form(
            key: formKeys[0],
            child: Column(children: [
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 30,
                controller: cumtomerNameController,
                decoration: const InputDecoration(
                  labelText: "Customer Name",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Customer Name";
                  }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: accountNumberController,
                decoration: const InputDecoration(
                  labelText: "Account Number",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Account number";
                  }
                  if (value.length != 10) {
                    return "Account number should be exactly 10 characters long";
                  }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Phone number";
                  }
                  if (value.length != 10) {
                    return "Phone number should be exactly 10 characters long";
                  }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 12,
                controller: NICNumberController,
                decoration: const InputDecoration(
                  labelText: "NIC Number",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter NIC number";
                  }
                  // if (value.length != 12) {
                  //   return "NIC number should be exactly 12 characters long";
                  // }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: mobileNumberController,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Mobile number";
                  }
                  if (value.length != 10) {
                    return "Mobile number should be exactly 10 characters long";
                  }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
            ]),
          ),
          isActive: currentStep >= 0,
          state: currentStep >= 0 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: const Text('CSU Details'),
          content: Form(
            key: formKeys[1],
            child: Column(children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: "Reason",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return "Please enter Reason";
                  // }
                  // if (value.length != 10) {
                  //   return "Mobile number should be exactly 10 characters long";
                  // }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: CSUNoteController,
                decoration: const InputDecoration(
                  labelText: "CSU Note",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter CSU Note";
                  }
                  // if (value.length != 6) {
                  //   return "CSU Note should be exactly 06 characters long";
                  // }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: CollectedCPENoteController,
                decoration: const InputDecoration(
                  labelText: "Collected CPE Note",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter collected CPE note";
                  }
                  // if (value.length != 6) {
                  //   return "Collected CPE note should be exactly 06 characters long";
                  // }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 06,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: CSUOfficerServiceNoController,
                decoration: const InputDecoration(
                  labelText: "CSU Officer Service No.",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter CSU Officer Service No.";
                  }
                  if (value.length != 6) {
                    return "CSU Officer Service No. should be exactly 06 characters long";
                  }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 20,
                controller: CSUOfficerNameController,
                decoration: const InputDecoration(
                  labelText: "CSU Officer Name",
                  filled: true,
                  fillColor: Color.fromARGB(147, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter CSU Officer Service No.";
                  }
                  // if (value.length != 6) {
                  //   return "CSU Officer Service No. should be exactly 06 characters long";
                  // }
                  return null;
                },
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    const SizedBox
                        .shrink(), // this will hide the counter indicator
              ),
            ]),
          ),
          isActive: currentStep >= 1,
          state: currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: const Text('Customer Signature'),
          content: Form(
            key: formKeys[2],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Signature(
                      controller: _controller,
                      height: 200,
                      backgroundColor: Colors.white,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          _controller.clear();
                        },
                        child: Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isActive: currentStep >= 2,
          state: currentStep >= 2 ? StepState.complete : StepState.disabled,
        )
      ];

  Future<void> _CreatePDF() async {
    final image = await _controller.toImage();
    final imageSignature =
        await image!.toByteData(format: ui.ImageByteFormat.png);

    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    // Load the logo image
    // final Uint8List logoData = File('assets/logo.png').readAsBytesSync();
    // final PdfBitmap logoImage = PdfBitmap(logoData);

    // // Draw the logo image at the top of the page
    // page.graphics.drawImage(logoImage, Rect.fromLTWH(50, 50, 100, 50));

    // Define the font and font size
    final font = PdfStandardFont(PdfFontFamily.helvetica, 12);
    final font2 = PdfStandardFont(PdfFontFamily.helvetica, 8);
    final font3 = PdfStandardFont(PdfFontFamily.helvetica, 20);

    // Set the position of the first line of text
    int myInt = 50;
    double yPosition = myInt.toDouble();

    final logoImage = await rootBundle.load('assets/slt.png');
    final PdfBitmap pdfLogo = PdfBitmap(logoImage.buffer.asUint8List());
    page.graphics.drawImage(pdfLogo, const Rect.fromLTWH(175, 0, 200, 100));
    yPosition += 50;

    page.graphics.drawLine(
        PdfPen(PdfColor(0, 0, 0)), Offset(25, yPosition as double),
        Offset(550, yPosition as double));
        yPosition += 25;

    page.graphics.drawString('Termination Request', font3,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 25;

    // Write each line of text to the page
    page.graphics.drawString(
        'Customer Name: ${cumtomerNameController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 25;

    page.graphics.drawString(
        'Account Number: ${accountNumberController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 25;

    page.graphics.drawString(
        'Phone Number: ${phoneNumberController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 25;

    page.graphics.drawString('NIC Number: ${NICNumberController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 25;

    page.graphics.drawString('Reason: ${reasonController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 40));
    yPosition += 40;

    page.graphics.drawString('CUS Note: ${CSUNoteController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 40));
    yPosition += 40;

    page.graphics.drawString(
        'CUS Officer Number: ${CSUOfficerServiceNoController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 25;

    page.graphics.drawString(
        'CSU Officer Name: ${CSUOfficerNameController.text}', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 50;

    // Draw the signature image onto the page
    final PdfBitmap signatureImage =
        PdfBitmap(imageSignature!.buffer.asUint8List());

    page.graphics.drawImage(
        signatureImage, Rect.fromLTWH(25, yPosition as double, 100, 50));
    yPosition += 50;

    page.graphics.drawString('Customer Signature', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 30;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(now);
    page.graphics.drawString('Date and Time: $formattedDate', font,
        bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 200;

    page.graphics.drawString('The PDF file was automatically generated via the Green Office mobile application, a digital solution that helps reduce paper consumption and facilitates data collection.', font2,
      bounds: Rect.fromLTWH(25, yPosition as double, 500, 20));
    yPosition += 25;

    List<int> bytes = document.save();
    String filename = '${accountNumberController.text}numberchange.pdf';

    saveAndLaunchFile(bytes, filename);
    document.dispose();

    _resetForm();

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HiddenDrawer(decoration: BoxDecoration()),
      ),
    );
  }

  void alert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Request Completed Successfully!',
    );
  }

  void _resetForm() {
    cumtomerNameController.clear();
    accountNumberController.clear();
    phoneNumberController.clear();
    NICNumberController.clear();
    mobileNumberController.clear();
    CSUDetailsController.clear();
    reasonController.clear();
    CSUNoteController.clear();
    // CSUOfficerServiceNoController.clear();
    // CSUOfficerNameController.clear();
    _controller.clear();
  }
}

class SheetsColumn {
  static const String Customer_Name = 'customerName';
  static const String Account_Number = 'accountNumber';
  static const String Phone_Number = 'phoneNumber';
  static const String NIC_Number = 'NICNumber';
  static const String Mobile_Number = 'mobileNumber';
  static const String Reason = 'reason';
  static const String CSU_Note = 'CSUNote';
  static const String Collected_CPE_Note = 'CollectedCPENote';
  static const String CSU_Officer_ServiceNo = 'CSUOfficerServiceNo';
  static const String CSU_Officer_Name = 'CSUOfficerName';

  static List<String> getColumns() => [
        Customer_Name,
        Account_Number,
        NIC_Number,
        Mobile_Number,
        Phone_Number,
        Reason,
        CSU_Note,
        Collected_CPE_Note,
        CSU_Officer_ServiceNo,
        CSU_Officer_Name
      ];
}
