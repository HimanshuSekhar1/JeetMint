import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int _currentStep = 0;

  // Controllers for input fields
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  String selectedGender = "Male";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void nextStep() {
    if (_currentStep < 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Add your signup logic here
      Get.log("Signup Complete");
      Get.log("Name: ${nameController.text}");
      Get.log("DOB: ${dobController.text}");
      Get.log("Gender: $selectedGender");
      Get.log("Email: ${emailController.text}");
      Get.snackbar("Success", "Signup Complete!");
    }
  }

  Widget stepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: _currentStep == index ? Colors.blue : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "${index + 1}",
              style: TextStyle(
                color: _currentStep == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget stepOne() {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Full Name"),
        ),
        TextField(
          controller: dobController,
          decoration: const InputDecoration(labelText: "Date of Birth"),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            dobController.text = "${pickedDate?.toLocal()}".split(' ')[0];
                              },
        ),
        DropdownButtonFormField<String>(
          value: selectedGender,
          items: ['Male', 'Female', 'Other']
              .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
          decoration: const InputDecoration(labelText: "Gender"),
        ),
      ],
    );
  }

  Widget stepTwo() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: "Email"),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: "Password"),
          obscureText: true,
        ),
        TextField(
          controller: confirmPasswordController,
          decoration: const InputDecoration(labelText: "Confirm Password"),
          obscureText: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            stepIndicator(),
            const SizedBox(height: 20),
            Expanded(
              child: _currentStep == 0 ? stepOne() : stepTwo(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentStep < 1) {
                    nextStep();
                  } else {
                    // Add actual sign-up logic here
                    // After successful signup
                    Get.offAllNamed('/home');
                  }
                },
                child: Text(_currentStep < 1 ? "Next" : "Signup"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
