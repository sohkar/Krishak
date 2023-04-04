import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishak/utils/colors_data.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  List posts = [
    {
      "name": "Rohit Kumar",
      "post":
          "Finally harvested my crops for the season! Can't wait to sell them at the market and make some profits. #FarmingLife #HarvestSeason #FreshProduce",
      "image":
          "https://cloudfront-us-east-2.images.arcpublishing.com/reuters/ANFYODSPTZKLZIJJN2BNVRRRJM.jpg",
      "time": "12:00 Pm",
      "profile":
          "https://media.istockphoto.com/id/1205325344/photo/farmer-in-agricultural-field.jpg?s=612x612&w=0&k=20&c=krsRk4T2MsmMy6PmrpPDR0i_1ja3_jQaNl80fBejWck=",
    },
    {
      "name": "Sneha Patel",
      "post":
          "Another day, another challenge. Dealing with pests is no easy task, but I'm determined to protect my crops and ensure a good yield. #FarmingStruggles #PestControl #NeverGiveUp",
      "image": "https://pbs.twimg.com/media/DtoT5R5WoAAPy5o.jpg",
      "time": "1:30 Pm",
      "profile":
          "https://media.istockphoto.com/id/641940492/photo/rural-women-cutting-silage-for-domestic-cattle.jpg?b=1&s=170667a&w=0&k=20&c=gJoU9U7xYX0Bu3TO--cV8PxwqADXh5k85PxWcbwHhn4=",
    },
    {
      "name": "Rajesh Sharma",
      "post":
          "Just got back from the dairy farm, and my cows are producing more milk than ever before! Hard work really pays off. #DairyFarm #HappyCows #HardWorkPaysOff",
      "image":
          "https://media.istockphoto.com/id/1297005217/photo/farmer-pouring-raw-milk-into-container.jpg?s=612x612&w=0&k=20&c=toiruwu04HHkwnLZhpKEjNPqOHI7Kmut5NMGTFSGm4M=",
      "time": "4:00 Pm",
      "profile":
          "https://live.staticflickr.com/65535/48977465818_fa612bde63_b.jpg",
    },
    {
      "name": "Anjali Singh",
      "post":
          "The monsoon rains have been heavy this year, and my fields are thriving. So grateful for Mother Nature's blessings! #RainySeason #BountifulHarvest #GratefulFarmer",
      "image":
          "https://c.ndtvimg.com/2021-07/pqrv5ps_crops_625x300_10_July_21.jpg",
      "time": "7:30 Pm",
      "profile":
          "https://thumbs.dreamstime.com/b/pretty-young-indian-girl-posing-10118357.jpg",
    },
    {
      "name": "Sanjay Mehta",
      "post":
          "I may not have a fancy office job, but I love what I do. There's something so satisfying about working the land and providing for my family. #ProudFarmer #SimpleLife #FamilyFirst",
      "image":
          "https://img.freepik.com/premium-photo/indian-farmer-feeling-happy-proud-sugarcane-field_621325-10.jpg",
      "time": "10:00 Am",
      "profile":
          "https://i.pinimg.com/736x/c8/b2/76/c8b276ea169aecb66cd0b7e6ad114274--indian-man-shawl.jpg",
    },
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
                      "https://agronicfood.com/wp-content/uploads/2020/02/0-4.png",
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
                            "Social",
                            style: GoogleFonts.domine(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Personalised Feed for Farmers",
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
              SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //  add post textField and button
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            focusColor: ColorsContants.kDarkGreenColor,
                            hintText: "Add Post",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CircleAvatar(
                        backgroundColor: ColorsContants.kDarkGreenColor,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              posts[index]["profile"],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            posts[index]["name"],
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            posts[index]["time"],
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            posts[index]["post"],
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              posts[index]["image"],
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
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
