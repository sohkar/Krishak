import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishak/functions/auth.dart';
import 'package:krishak/main.dart';

import '../utils/colors_data.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  List<String> cropTypes = ["Kharif", "Rabi", "Zaid"];
  List<String> cropTypesSelected = [];
  List<String> topics = [
    "Weather Updates",
    "Daily Tips",
    "Crop Management",
    "Market Prices",
    "Farm Financial Management",
    "Sustainable Farming",
    "Government Regulations",
    "Government Schemes",
    "Farm Safety",
    "Agritourism",
  ];
  List<String> topicsSelected = [
    "Weather Updates",
    "Daily Tips",
  ];
  var loading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              autofillHints: const [AutofillHints.name],
                              decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle: GoogleFonts.domine(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _pincodeController,
                              autofillHints: const [AutofillHints.postalCode],
                              decoration: InputDecoration(
                                labelText: "Pincode",
                                labelStyle: GoogleFonts.domine(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Select Crop Type",
                              style: GoogleFonts.domine(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: cropTypes.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (cropTypesSelected
                                            .contains(cropTypes[index])) {
                                          cropTypesSelected
                                              .remove(cropTypes[index]);
                                        } else {
                                          cropTypesSelected
                                              .add(cropTypes[index]);
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Chip(
                                        label: Text(
                                          cropTypes[index],
                                          style: cropTypesSelected
                                                  .contains(cropTypes[index])
                                              ? const TextStyle(
                                                  color: Colors.white)
                                              : const TextStyle(fontSize: 12),
                                        ),
                                        backgroundColor: cropTypesSelected
                                                .contains(cropTypes[index])
                                            ? ColorsContants.kLightGreenColor
                                            : ColorsContants.kLightGreenColor
                                                .withOpacity(0.1),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Select Topics",
                              style: GoogleFonts.domine(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                color: ColorsContants.kLightGreenColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: topics.length,
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    dense: true,
                                    visualDensity: VisualDensity.compact,
                                    value:
                                        topicsSelected.contains(topics[index]),
                                    onChanged: (value) {
                                      if (topics[index] != "Weather Updates" ||
                                          topics[index] != "Daily Tips") {
                                        setState(
                                          () {
                                            if (topicsSelected
                                                .contains(topics[index])) {
                                              topicsSelected
                                                  .remove(topics[index]);
                                            } else {
                                              topicsSelected.add(topics[index]);
                                            }
                                          },
                                        );
                                      }
                                    },
                                    activeColor:
                                        ColorsContants.kLightGreenColor,
                                    checkColor: Colors.white,
                                    side: const BorderSide(
                                      color: ColorsContants.kLightGreenColor,
                                    ),
                                    title: Text(
                                      topics[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.name,
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
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: GoogleFonts.domine(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        TextField(
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
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
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () {
                              if (_nameController.text.isEmpty ||
                                  _pincodeController.text.isEmpty ||
                                  _emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  _confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Please fill all the fields"),
                                  ),
                                );
                              } else if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Passwords do not match"),
                                  ),
                                );
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                Auth().signUp(_emailController.text,
                                    _passwordController.text, {
                                  "fullName": _nameController.text,
                                  "pincode": _pincodeController.text,
                                  "cropTypes": cropTypesSelected,
                                  "topics": topicsSelected,
                                }).then((value) => {
                                      setState(() {
                                        loading = false;
                                      }),
                                      if (value["status"] == true)
                                        {
                                          navigatorKey.currentState!.popUntil(
                                            (route) => route.isFirst,
                                          ),
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(value["message"]),
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
            ),
          ),
        ),
      ),
    );
  }
}
