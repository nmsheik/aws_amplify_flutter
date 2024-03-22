import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/logIn.dart';
import 'package:aws_amplify_flutter/otp.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final loginForm = GlobalKey<FormState>();
  late Map<String, TextEditingController> loginFormController = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                          'email'], // Add a controller for email
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Email', // Change the label to 'Email'
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      validator: (String? value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);

                        if (value == '' || value.isEmpty) {
                          return 'Please Provide Email';
                        } else if (!emailValid) {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      controller: loginFormController[
                          'password'], // Add a controller for email
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password', // Change the label to 'Email'
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Please Provide Email';
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
                    createPressed(context);
                  } else {
                    // setState(() => _autoValidate = AutovalidateMode.always);
                    print('AKBAR');
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Set button color
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6.0), // Set border radius
                      ),
                    )),
                child: Container(
                  height: 56,
                  child: Center(
                    child: Text(
                      'Create Account',
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => login()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Set button color
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6.0), // Set border radius
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
        ),
      ),
    );
  }

  Future<void> createPressed(BuildContext context) async {
    if (loginForm.currentState!.validate()) {
      final email = loginFormController['email']!.text;
      final password = loginFormController['password']!.text;
      try {
        final sigupresult = await Amplify.Auth.signUp(
            username: email,
            password: password,
            // ignore: deprecated_member_use
            options: CognitoSignUpOptions(
                userAttributes: {CognitoUserAttributeKey.email: email}));

        print('sheik$sigupresult');
        // if (sigupresult.isSignUpComplete) {
        print('malik');
        print(email);
        emailsend(context, email);
        // } else {
        print('ERROR123456789');
        // }
      } catch (e) {
        print('sheik$e');
      }
    } else {
      print('AKBAR');
    }
  }

  void emailsend(BuildContext context, String email) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => otp(email: email),
        ));
  }
}
