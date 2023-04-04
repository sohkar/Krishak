import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishak/utils/colors_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Scheme extends StatefulWidget {
  const Scheme({Key? key}) : super(key: key);

  @override
  State<Scheme> createState() => _SchemeState();
}

class _SchemeState extends State<Scheme> {
  List schemes = [
    {
      "name": "Pradhan Mantri Fasal Bima Yojana",
      "link": "https://pmfby.gov.in/",
    },
    {
      "name": "Pradhan Mantri Kisan Samman Nidhi Yojana",
      "link": "https://pmfby.gov.in/",
    },
    {
      "name": "Kisan Credit Card",
      "link": "https://www.pnbagriline.in/kcc-scheme.aspx",
    },
    {
      "name": "Pradhan Mantri Krishi Sinchai Yojana",
      "link": "https://pmfby.gov.in/",
    },
    {
      "name": " Soil Health Card Scheme",
      "link": "https://soilhealth.dac.gov.in/",
    },
    {
      "name": " Rashtriya Krishi Vikas Yojana",
      "link": "https://rkvy.nic.in/",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: Stack(
                  children: [
                    Image.network(
                      "https://static.toiimg.com/photo/msid-88958328/88958328.jpg",
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Government Schemes",
                            style: GoogleFonts.domine(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Government Schemes for Farmers",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ListView.builder(
                  itemCount: schemes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        schemes[index]["name"],
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: ColorsContants.kDarkGreenColor,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          if (await launch(schemes[index]["link"])) {
                            await launch(
                              schemes[index]["link"],
                            );
                          } else {
                            throw 'Could not launch url';
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
