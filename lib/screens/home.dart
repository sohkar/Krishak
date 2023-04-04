import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:krishak/functions/auth.dart';
import 'package:krishak/main.dart';
import 'package:krishak/utils/colors_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _greeting = '';

  @override
  void initState() {
    super.initState();
    _setGreeting();
  }

  Future<void> _setGreeting() async {
    var now = DateTime.now();
    var formatter = DateFormat('H');
    var hour = int.parse(formatter.format(now));

    if (hour < 12) {
      setState(() {
        _greeting = 'Good morning!';
      });
    } else if (hour < 18) {
      setState(() {
        _greeting = 'Good afternoon!';
      });
    } else {
      setState(() {
        _greeting = 'Good evening!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    ColorsContants.kLightGreenColor,
                    ColorsContants.kDarkGreenColor,
                  ],
                ),
              ),
              child: Center(
                child: Image.asset("assets/leaf.png"),
              ),
            ),
            ListTile(
              title: const Text('Community'),
              onTap: () {
                Navigator.pushNamed(context, '/community');
              },
            ),
            ListTile(
              title: const Text('Government Schemes'),
              onTap: () {
                print("Schemes");
                Navigator.pushNamed(context, '/schemes');
              },
            ),
            ListTile(
              title: const Text('Education'),
              onTap: () {
                print("Education");
                Navigator.pushNamed(context, '/education');
              },
            ),
            ListTile(
              tileColor: Colors.grey[200],
              title: const Text('Logout'),
              onTap: () {
                Auth().signOut();
                navigatorKey.currentState!.popUntil(
                  (route) => route.isFirst,
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                    RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        text: '${_greeting.split(" ")[0]} \n',
                        style: GoogleFonts.domine(
                          color: ColorsContants.kLightGreenColor,
                          fontSize: 22,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: _greeting.split(" ")[1],
                            style: GoogleFonts.domine(
                              color: ColorsContants.kDarkGreenColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 0.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: 'Daily ',
                    style: GoogleFonts.domine(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Update",
                        style: GoogleFonts.domine(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const WeatherContainer(),
                const PriceContainer(),
                const NewsContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherContainer extends StatefulWidget {
  const WeatherContainer({super.key});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  String _temp = '';
  String _windDirection = '';
  String _windSpeed = '';
  String _humidity = '';
  String _cloud = '';

  @override
  void initState() {
    super.initState();
    getLoaction();
  }

  Future<void> getLoaction() async {
    await Geolocator.isLocationServiceEnabled();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    http.Response response = await http.get(
        Uri.parse(
          "https://weatherapi-com.p.rapidapi.com/current.json?q=${position.latitude},${position.longitude}",
        ),
        headers: {
          "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
          "X-RapidAPI-Key": "2c4683cfccmshd1653ca05a12dadp156913jsnf516a538d63a"
        });

    print(jsonDecode(response.body));
    setState(() {
      _temp = jsonDecode(response.body)['current']['temp_c'].toString();
      _windDirection = jsonDecode(response.body)['current']['wind_dir'];
      _windSpeed = jsonDecode(response.body)['current']['wind_kph'].toString();
      _humidity = jsonDecode(response.body)['current']['humidity'].toString();
      _cloud = jsonDecode(response.body)['current']['cloud'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsContants.kLightGreenColor,
            ColorsContants.kDarkGreenColor,
          ],
        ),
      ),
      child: _windDirection == ""
          ? const Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/cloudy.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_temp.split(".")[0]}°C",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 22.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cloud $_cloud%",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Humidity $_humidity%",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Container(
                      height: 80,
                      width: 1,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/wind.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_windSpeed.split(".")[0]} kph",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 22.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  _windDirection == "S"
                                      ? "South"
                                      : _windDirection == "N"
                                          ? "North"
                                          : _windDirection == "E"
                                              ? "East"
                                              : "West",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  _windDirection == "S"
                                      ? "↓"
                                      : _windDirection == "N"
                                          ? "↑"
                                          : _windDirection == "E"
                                              ? "→"
                                              : "←",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class PriceContainer extends StatelessWidget {
  const PriceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    List products = [
      {
        "name": "Rice",
        "image": "assets/rice.png",
        "price": "₹2400.00/Quintal",
        "bg": Colors.redAccent.withOpacity(0.8)
      },
      {
        "name": "Wheat",
        "image": "assets/wheat.png",
        "price": "₹2600/Quintal",
        "bg": Colors.blueAccent.withOpacity(0.8)
      },
      {
        "name": "Potato",
        "image": "assets/potato.png",
        "price": "₹600.00/Quintal",
        "bg": Colors.orangeAccent.withOpacity(0.9)
      },
      {
        "name": "Tomato",
        "image": "assets/tomato.png",
        "price": "1000.00/Quintal",
        "bg": Colors.blueAccent.withOpacity(0.8)
      },
      {
        "name": "Cauliflower",
        "image": "assets/cauliflower.png",
        "price": "₹1200.00/Quintal",
        "bg": Colors.indigoAccent.withOpacity(0.8)
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (
            context,
            index,
          ) {
            return Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: products[index]["bg"],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        products[index]["image"],
                        height: 35,
                        width: 35,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index]["name"],
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "₹2400.00/Quintal",
                            style: GoogleFonts.montserrat(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10)
              ],
            );
          },
        ),
      ),
    );
  }
}

class NewsContainer extends StatelessWidget {
  const NewsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    List news = [
      {
        "title":
            "Government to buy 3 lakh tonnes of onion in Rabi season: Union Minister Piyush Goyal",
        "description":
            "Union Minister Piyush Goyal on Thursday announced that the government agencies will buy 3 lakh tonnes of onion once the winter harvest starts coming in. Goyal, who handles the Consumer Affairs, Food and Public distribution portfolio, said that last year, the overall buying of the rabi harvest stood at 2.5 lakh tonnes.",
        "image":
            "https://img.etimg.com/thumb/msid-99120546,width-160,height-120,imgsize-98356/government-to-buy-3-lakh-tonnes-of-onion-in-rabi-season-union-minister-piyush-goyal.jpg",
        "source": "The Economic Times",
      },
      {
        "title":
            "Sugar getting even pricier poses new threat to food inflation",
        "description":
            "Prices of refined sugar surged to the highest in more than a decade this week, while the raw variety is near to the costliest in over six years. Global supply is tightening, mainly because India, one of the top shippers, has cut exports after rains hurt the sugar cane crop and as more sweetener is diverted to biofuel.",
        "image":
            "https://img.etimg.com/thumb/msid-99106340,width-160,height-120,imgsize-219146/sugar-getting-even-pricier-poses-new-threat-to-food-inflation.jpg",
        "source": "Hitavada",
      },
      {
        "title": "Tur, urad prices jump by 8-10% in a month",
        "description":
            "The bullish sentiments in tur and sudden sharp jump in prices last week has influenced prices of the entire pulses complex.",
        "image":
            "https://img.etimg.com/thumb/msid-99076395,width-160,height-120,imgsize-137450/tur-urad-prices-jump-by-8-10-in-a-month.jpg",
        "source": "The Economic Times",
      },
      {
        "title": "Wheat procurement begins: Food ministry",
        "description":
            "The government expects to procure a total of 341.50 LMT wheat during RMS 2023-24 as against 187.92 LMT wheat actually procured during last RMS 2022-23. As per the Second Advance Estimates published by Ministry of Agriculture & Farmers Welfare, the estimated production of wheat is around 112.1 million tonnes this season.",
        "image":
            "https://img.etimg.com/thumb/msid-99067868,width-160,height-120,imgsize-74698/wheat-procurement-begins-food-ministry.jpg",
        "source": "Navbharat Times",
      }
    ];
    return Expanded(
        child: ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          height: 20,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        );
      },
      physics: const BouncingScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          minVerticalPadding: 10,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              news[index]["title"],
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          subtitle: Text(
            news[index]["description"],
            style: GoogleFonts.montserrat(
              color: Colors.black.withOpacity(0.75),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Image.network(
            news[index]["image"],
            height: 50,
            width: 50,
          ),
        );
      },
    ));
  }
}
