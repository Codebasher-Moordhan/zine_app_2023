import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/utilities/DateTime.dart';
import 'package:zineapp2023/utilities/string_formatters.dart';
import 'package:intl/intl.dart';
import '../../common/routing.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  dynamic routes = {
    "ALGORITHMS": "ALGO",
    "BEE": "BEE",
    "BME": "BME",
    "AEROMODELLING": "AERO",
    "IC-MCU": "IC-MCU",
    "CYBERSECURITY": "CYBERSECURITY",
    "WEB DEVELOPMENT": "WEBDEV",
    "MACHINE LEARNING": "ML"
  };

  @override
  Widget build(BuildContext context) {
    return Consumer2<DashboardVm, UserProv>(
      builder: (context, dashboardVm, userProv, _) {
        dashboardVm.getRecentEvent();
        UserModel currUser = userProv.getUserInfo();
        String month = DateFormat.MMMM().format(DateTime.now());

        return Scaffold(
          extendBody: true,
          body: Center(
            child: Container(
              decoration: const BoxDecoration(
                color: backgroundGrey,
              ),
              height: double.infinity,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.of(context)
                              .push(Routes.profileScreen());
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text("hi",
                                      style: TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff646464))),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(currUser.name.toString().firstName(),
                                      style: const TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0C72B0))),
                                ],
                              ),
                              const Spacer(),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: iconTile,
                                backgroundImage: AssetImage(
                                  "assets/images/dp/${currUser.dp}.png",
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),

                      // * Priyansh ko Gaaliya :) *

                      // const Padding(
                      //   padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                      //   child: Text("EVENTS",
                      //       style: TextStyle(
                      //           height: 0.9,
                      //           letterSpacing: 0.3,
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w700,
                      //           color: greyText)),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 25, 0),
                                      child: Text(
                                        10 <= DateTime.now().day &&
                                                DateTime.now().day <= 20
                                            ? "TH"
                                            : DateTime.now().day % 10 == 1
                                                ? "ST"
                                                : DateTime.now().day % 10 == 2
                                                    ? "ND"
                                                    : DateTime.now().day % 10 ==
                                                            3
                                                        ? "RD"
                                                        : "TH",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                                18,
                                            color: Color(0xff0C72B0)),
                                      ),
                                    ),
                                    Text(
                                      DateTime.now().day.toString(),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              70,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff0C72B0)),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      month.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                              25,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xffa3d0ec)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(Routes.Event())
                                },
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      dashboardVm.events.length != 0
                                          ? Text(
                                              dashboardVm.events[0].eventType,
                                              style: const TextStyle(
                                                  height: 0.9,
                                                  letterSpacing: 0.3,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xff646464)))
                                          : Container(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      dashboardVm.events.length != 0
                                          ? Text(
                                              dashboardVm.events[0]!.name,
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff0C72B0)),
                                              textAlign: TextAlign.center,
                                            )
                                          : Container(),
                                      // const SizedBox(
                                      //   height: 0,
                                      // ),
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        height: 110,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(24.0),
                                              bottomRight:
                                                  Radius.circular(24.0)),
                                          color: Color(0xff0C72B0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              dashboardVm.events.length > 0
                                                  ? DateFormat.MMMMd().format(
                                                      dashboardVm
                                                          .events[0]!.timeDate
                                                          .toDate())
                                                  : "Date",
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      200, 255, 255, 255)),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              dashboardVm.events.length > 0
                                                  ? '${DateFormat.jm().format(dashboardVm.events[0]!.timeDate.toDate())}\n ${dashboardVm.events[0]!.venue}'
                                                  : "Venue",
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 200.0, viewportFraction: 0.87),
                        items: [
                          "ALGORITHMS",
                          "BEE",
                          "BME",
                          "AEROMODELLING",
                          "IC-MCU",
                          // "CYBERSECURITY",
                          "WEB DEVELOPMENT",
                          "MACHINE LEARNING"
                        ].map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    dashboardVm.launchUrl(
                                        'https://zine.co.in/blogs/${routes[i].toLowerCase()}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.5, vertical: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/blog_card.png")),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                      child: Center(
                                        child: Text(
                                          i,
                                          style: const TextStyle(
                                              height: 0.9,
                                              letterSpacing: 0.3,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w600,
                                              color: textColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.45,
                              height: 125.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(Routes.tasks())
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w600,
                                          color: greyText),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Tasks",
                                        style: TextStyle(
                                            height: 0.9,
                                            letterSpacing: 0.3,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: greyText)),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.of(context).push(Routes.chatHome())
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.45,
                                height: 125.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w600,
                                          color: textColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Chats",
                                        style: TextStyle(
                                            height: 0.9,
                                            letterSpacing: 0.3,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: greyText)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
