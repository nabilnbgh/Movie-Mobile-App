import 'package:flutter/material.dart';

import 'package:movie_application/service/authservice.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  AuthService auth = AuthService();
  bool isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Login/Register',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                margin: const EdgeInsets.all(16.0),
                elevation: 20.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Email"),
                            TextFormField(
                              controller: emailController,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter Email" : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'example@email.com',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const Text("Password"),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password";
                                } else {
                                  if (value.length < 6) {
                                    return "Password need to have 6+ chars long";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              controller: passwordController,
                              obscureText: !isPasswordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic user = await auth.signUpEmailPassword(
                              emailController.text, passwordController.text);
                          if (user == null) {
                            setState(() {
                              error = 'Please supply valid email';
                            });
                          }
                        }
                      },
                      child: const Text("Register"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic user = await auth.signInEmailPassword(
                              emailController.text, passwordController.text);
                          if (user == null) {
                            setState(() {
                              error = 'Email atau Password Salah';
                            });
                          }
                        }
                      },
                      child: const Text("Login"),
                    ),
                    error != ""
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              error,
                              style: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
