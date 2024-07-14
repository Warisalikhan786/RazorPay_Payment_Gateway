import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Razorpay _razorpay = Razorpay();
  @override
  Widget build(BuildContext context) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("RazorPay Gateway"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var options = {
              'key': 'Your Key',
              'amount': 1000,
              'currency': 'USD',
              'name': 'Acme Corp.',
              'description': 'Fine T-Shirt',
              'prefill': {
                'contact': '8888888888',
                'email': 'test@razorpay.com',
              }
            };

            _razorpay.open(options);
          },
          child: const Text("Pay"),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    if (kDebugMode) {
      print("payment success");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    if (kDebugMode) {
      print(" payment failed");
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}
