import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishak/functions/auth.dart';
import 'package:krishak/main.dart';
import 'package:krishak/utils/colors_data.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var loading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.9),
              child: loading
                  ? const Center(child: CupertinoActivityIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        Text(
                          "sign up",
                          style: GoogleFonts.domine(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle: GoogleFonts.domine(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            TextField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              autofillHints: const [AutofillHints.password],
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: GoogleFonts.domine(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorsContants.kLightGreenColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: () {
                                  if (_emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Please fill all the fields"),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      loading = true;
                                    });
                                    Auth()
                                        .signIn(_emailController.text,
                                            _passwordController.text)
                                        .then((value) => {
                                              setState(() {
                                                loading = false;
                                              }),
                                              if (value['status'] == true)
                                                {
                                                  navigatorKey.currentState!
                                                      .popUntil(
                                                    (route) => route.isFirst,
                                                  )
                                                }
                                              else
                                                {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          value['message']),
                                                    ),
                                                  )
                                                }
                                            });
                                  }
                                },
                                child: Text(
                                  "sign up",
                                  style: GoogleFonts.domine(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
