import 'package:flutter/material.dart';

class QrCreater extends StatefulWidget {
  const QrCreater({Key? key}) : super(key: key);

  @override
  State<QrCreater> createState() => _QrCreaterState();
}

class _QrCreaterState extends State<QrCreater> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // QrImage(
              //   data: controller.value.text,
              //   size: 200,
              //   backgroundColor: Colors.white,
              // ),
              const SizedBox(
                height: 40,
              ),
              buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) => TextField(
        maxLength: 50,
        controller: controller,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: 'Please enter data!'.padLeft(15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.green.shade800,
            onPressed: () => setState(() {}),
            icon: Icon(
              Icons.done,
              size: 28,
            ),
          ),
        ),
      );
  final controller = TextEditingController();
}
