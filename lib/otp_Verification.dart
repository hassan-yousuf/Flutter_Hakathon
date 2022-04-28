import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class otpVerification extends StatefulWidget {
  const otpVerification({Key? key}) : super(key: key);

  @override
  State<otpVerification> createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  late EmailAuth emailAuth;
  bool submitValid = false;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Hakathon Session",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loggedIn)
          ? Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(17.0),
                ),
                onPressed: () {
                  setState(() {
                    loggedIn = false;
                    emailController.clear();
                    otpController.clear();
                  });
                },
                child: Text(
                  'LogOut from OTP',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 49,
                    width: 290,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Enter your email!',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        suffixIcon: TextButton(
                          onPressed: sendOtp,
                          child: Text('Send Otp'),
                        ),
                      ),
                    ),
                  ),
                  (submitValid)
                      ? Container(
                          height: 70,
                          width: 285,
                          child: TextField(
                            obscureText: isVisible = !isVisible,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            controller: otpController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              labelText: 'Please verify the otp!',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(height: 1),
                  (submitValid)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(17.0),
                          ),
                          onPressed: verifyOtp,
                          child: Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        )
                      : SizedBox(height: 1),
                ],
              ),
            ),
    );
  }

  bool isVisible = true;

  void sendOtp() async {
    var res =
        await emailAuth.sendOtp(recipientMail: emailController.value.text);

    if (res) {
      Fluttertoast.showToast(
        msg: 'OTP Sent',
      );
      setState(() {
        submitValid = true;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'We couldn\'t sent the OTP',
      );
    }
  }

  void verifyOtp() {
    var res = emailAuth.validateOtp(
      recipientMail: emailController.value.text,
      userOtp: otpController.text,
    );

    if (res) {
      Fluttertoast.showToast(
        msg: 'Congratulation\'s',
      );
      setState(() {
        loggedIn = true;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Invalid OTP',
      );
    }
  }
}
