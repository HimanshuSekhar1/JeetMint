// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  int _step = 1;
  String phoneNumber = '';
  String otpCode = '';

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  void _sendOtp() {
    setState(() {
      _step = 2;
    });

    // Add your OTP send logic here using Firebase
    print("OTP sent to $phoneNumber");
  }

  void _verifyOtp() {
    // Add your OTP verification logic here
    print("Verifying OTP: $otpCode");
    Get.offAllNamed('/home'); // Navigate to home screen
  }

  void _resendOtp() {
    // Resend OTP logic here
    print("Resending OTP to $phoneNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _step == 1 ? _buildPhoneStep() : _buildOtpStep(),
      ),
    );
  }

  Widget _buildPhoneStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Enter your phone number", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
        IntlPhoneField(
          controller: phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          initialCountryCode: 'IN',
          onChanged: (phone) {
            phoneNumber = phone.completeNumber;
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _sendOtp,
          child: const Text("Send OTP"),
        ),
      ],
    );
  }

  Widget _buildOtpStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Enter OTP", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          onChanged: (value) => otpCode = value,
          decoration: const InputDecoration(
            labelText: "OTP",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: _resendOtp,
          child: const Text("Resend OTP"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _verifyOtp,
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}
