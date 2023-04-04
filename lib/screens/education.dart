import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishak/utils/colors_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Education extends StatefulWidget {
  const Education({Key? key}) : super(key: key);

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  List resources = [
    {
      "name":
          "'Small Scale Dairy Farming' by University of Maine Cooperative Extension",
      "url": "https://www.youtube.com/watch?v=mN9c2jy8S0g"
    },
    {
      "name": "'How to Grow Tomatoes - Complete Growing Guide' by MIgardener",
      "url": "https://www.youtube.com/watch?v=TGmYy7P80V8"
    },
    {
      "name": "'Introduction to Beekeeping' by Beekeeping Like A Girl",
      "url": "https://www.youtube.com/watch?v=LG1yxNi-X9o"
    },
    {
      "name": "'Organic Farming in India' by Krish India",
      "url": "https://www.youtube.com/watch?v=qkqtcXuogu4"
    },
    {
      "name": "'Sheep Farming for Beginners' by Farming My Backyard",
      "url": "https://www.youtube.com/watch?v=YGP4cjWHff4"
    },
    {
      "name": "'How to Start a Vegetable Garden' by Lowe's Home Improvement",
      "url": "https://www.youtube.com/watch?v=NlS_dTDsHHQ"
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
                      "https://live.staticflickr.com/7036/6893651817_2668a3f50b_b.jpg",
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
                            "Learn",
                            style: GoogleFonts.domine(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Curated Resources just for Farmers",
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
                  itemCount: resources.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.video_collection,
                        color: Colors.red,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: ColorsContants.kDarkGreenColor,
                      ),
                      title: Text(
                        resources[index]["name"],
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: ColorsContants.kDarkGreenColor,
                        ),
                      ),
                      onTap: () async {
                        if (await launch(resources[index]["url"])) {
                          await launch(resources[index]["url"]);
                        } else {
                          throw 'Could not launch url';
                        }
                      },
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
