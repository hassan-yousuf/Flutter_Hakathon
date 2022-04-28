import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class paymentGateway extends StatefulWidget {
  const paymentGateway({Key? key}) : super(key: key);

  @override
  State<paymentGateway> createState() => _paymentGatewayState();
}

class _paymentGatewayState extends State<paymentGateway> {
  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccessHandler);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentErrorHandler);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  late Razorpay razorpay;

  void paymentSuccessHandler() {
    Fluttertoast.showToast(msg: 'Payment Success');
    controller.clear();
    controllers.clear();
    controllerss.clear();
    _controller.clear();
  }

  void paymentErrorHandler() {
    Fluttertoast.showToast(msg: 'Payment Error');
  }

  void externalWalletHandler() {
    Fluttertoast.showToast(msg: 'External Wallet');
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_nckP07t5OTi5jy",
      "amount": num.parse(controller.value.text) * 100,
      "name": controllerss.text,
      "description": "Payment For Hakathon!",
      "prefill": {
        "contact": controllers.text,
        "email": _controller.text,
      },
      "external": {
        "wallets": ["Paytm"],
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 49,
              width: 290,
              child: TextField(
                keyboardType: TextInputType.name,
                controller: controllerss,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            Container(
              height: 49,
              width: 290,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            Container(
              height: 70,
              width: 285,
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                controller: controllers,
                decoration: InputDecoration(
                  labelText: 'Enter your phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            Container(
              height: 70,
              width: 285,
              child: TextField(
                maxLength: 5,
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter the amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                openCheckOut();
              },
              child: Text('Payment Now!'),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController controller = TextEditingController();
  TextEditingController _controller = TextEditingController();
  TextEditingController controllers = TextEditingController();
  TextEditingController controllerss = TextEditingController();
}
