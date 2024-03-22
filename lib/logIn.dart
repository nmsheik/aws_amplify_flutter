import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/mainScreen.dart';
import 'package:aws_amplify_flutter/signUp.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final loginForm = GlobalKey<FormState>();
  late Map<String, TextEditingController> loginFormController = {
    'email': TextEditingController(),
    'password': TextEditingController(),
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
                                'email'], // Add a controller for email
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText:
                                  'Password', // Change the label to 'Email'
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
                          loginPressed();
                        } else {
                          print('AKBAR');
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
                        // context.pop();
                        createPressed();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff454545)), // Set button color
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(6.0), // Set border radius
                          ),
                        ),
                      ),
                      child: Container(
                        height: 56,
                        child: const Center(
                          child: Text(
                            'Create account',
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

  void loginPressed() async {
    final email = loginFormController['email']!.text;
    final password = loginFormController['password']!.text;

    try {
      await Amplify.Auth.signOut();
      final signInResult =
          await Amplify.Auth.signIn(username: email, password: password);

      if (signInResult.isSignedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => mainscreen()));
      } else {
        print('SheikIbrahim');
      }
    } catch (e) {
      print('ERROR123$e');
      print('SheikIbrahim');
    }
  }

  void createPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const signup(),
        ));
  }
}
