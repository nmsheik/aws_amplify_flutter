import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/logIn.dart';
import 'package:flutter/material.dart';

class otp extends StatefulWidget {
  final String email;
  const otp({super.key, required this.email});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  final loginForm = GlobalKey<FormState>();
  late Map<String, TextEditingController> loginFormController = {
    'OTP': TextEditingController(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Form(
                      key: loginForm,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            controller: loginFormController[
                                'OTP'], // Add a controller for email
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'OTP', // Change the label to 'Email'
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            validator: (value) {
                              if (value == '') {
                                return 'Please Provide OTP';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (loginForm.currentState!.validate()) {
                          // login();
                          loginPressed();
                        } else {
                          // setState(() => _autoValidate = AutovalidateMode.always);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black), // Set button color
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  6.0), // Set border radius
                            ),
                          )),
                      child: Container(
                        height: 56,
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 26.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => login()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black), // Set button color
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  6.0), // Set border radius
                            ),
                          )),
                      child: Container(
                        height: 56,
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void loginPressed() async {
  //   final otp = loginFormController['otp']!.text;
  //   print(otp);
  //   var signUpResult = await Amplify.Auth.confirmSignUp(
  //       confirmationCode: otp, username: widget.email);
  //   if (signUpResult.isSignUpComplete) {
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => login()));
  //   }
  // }
  void loginPressed() async {
    print('sheik');
    var otp = loginFormController['OTP']!.text;
    print(otp);
    if (otp != null && widget.email != null) {
      try {
        var signUpResult = await Amplify.Auth.confirmSignUp(
            confirmationCode: otp, username: widget.email!);
        if (signUpResult.isSignUpComplete) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => login()));
        }
      } catch (e) {
        print('Error confirming sign-up: $e');
      }
    } else {
      print('OTP or email is null');
    }
  }
}
