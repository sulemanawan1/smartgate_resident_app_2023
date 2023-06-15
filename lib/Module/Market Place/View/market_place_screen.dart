import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../Constants/api_routes.dart';
import '../../../Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/Loader/loader.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../../Widgets/My Floating Action Button/my_floating_action_button.dart';
import '../../Chat Availbility/Model/ChatNeighbours.dart';
import '../../Chat Availbility/Model/ChatRoomModel.dart';
import '../../Chat Screens/Neighbour Chat Screen/Controller/neighbour_chat_screen_controller.dart';
import '../Controller/market_place_controller.dart';

class MarketPlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MarketPlaceController>(
          init: MarketPlaceController(),
          builder: (controller) {
            return WillPopScope(
              onWillPop: () async {
                await Get.offNamed(homescreen, arguments: controller.userdata);
                return true;
              },
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Market Place',
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: primaryColor,
                        tabs: [
                          Tab(
                            child: Text('Buy',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Tab(
                            child: Text('Sell',
                                style: TextStyle(color: primaryColor)),
                          ),
                        ],
                        labelColor: Colors.white,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            //Buy
                            FutureBuilder(
                                future: controller.viewProducts(
                                    societyid: controller.resident.societyid!,
                                    token: controller.userdata.bearerToken!),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        controller.snapshotData =
                                            snapshot.data.data[index];

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 343,
                                            child: Card(
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .snapshotData
                                                              .productname
                                                              .toString(),
                                                          style: GoogleFonts.ubuntu(
                                                              color: HexColor(
                                                                  '#606470'),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          controller
                                                              .snapshotData
                                                              .description
                                                              .toString(),
                                                          style: GoogleFonts.ubuntu(
                                                              color: HexColor(
                                                                  '#A5AAB7'),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text('price'),
                                                            Text(
                                                              controller
                                                                  .snapshotData
                                                                  .productprice
                                                                  .toString(),
                                                              style: GoogleFonts.ubuntu(
                                                                  color: HexColor(
                                                                      '#A5AAB7'),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  ChatNeighbours userInfo = await controller.productSellerInfoApi(
                                                                      residentid: snapshot
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .residentid,
                                                                      token: controller
                                                                          .userdata
                                                                          .bearerToken!);
                                                                  final ChatRoomModel chatRoomModel = await controller.createChatRoomApi(
                                                                      token: controller
                                                                          .userdata
                                                                          .bearerToken!,
                                                                      userid: controller
                                                                          .userdata
                                                                          .userId!,
                                                                      chatuserid: snapshot
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .residentid);

                                                                  Get.offNamed(
                                                                      neighbourchatscreen,
                                                                      arguments: [
                                                                        controller
                                                                            .userdata, //Login User
                                                                        controller
                                                                            .resident, // Resident Details
                                                                        userInfo
                                                                            .data!
                                                                            .first,
                                                                        chatRoomModel
                                                                            .data!
                                                                            .first
                                                                            .id,
                                                                        ChatTypes.MarketPlaceChat.toString()
                                                                            .split('.')
                                                                            .last, // Chat User
                                                                      ]);
                                                                },
                                                                icon: Icon(
                                                                  Icons.chat,
                                                                  color:
                                                                      primaryColor,
                                                                )),
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                  Icons.call,
                                                                  color: Colors
                                                                      .green,
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Image(
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        Api.imageBaseUrl +
                                                            controller
                                                                .snapshotData
                                                                .images
                                                                .toString()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Icon(Icons.error_outline);
                                  } else {
                                    return Loader();
                                  }
                                }),

                            //Sell

                            ListView(
                              children: [
                                Container(
                                  height: 600,
                                  child: FutureBuilder(
                                      future:
                                          controller.viewSellProductsResidnet(
                                              residentid: controller
                                                  .resident.residentid!,
                                              token: controller
                                                  .userdata.bearerToken!),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              controller.snapshotData2 =
                                                  snapshot.data.data[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 343,
                                                  child: Card(
                                                    elevation: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .snapshotData2
                                                                    .productname
                                                                    .toString(),
                                                                style: GoogleFonts.ubuntu(
                                                                    color: HexColor(
                                                                        '#606470'),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                controller
                                                                    .snapshotData2
                                                                    .description
                                                                    .toString(),
                                                                style: GoogleFonts.ubuntu(
                                                                    color: HexColor(
                                                                        '#A5AAB7'),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text('price'),
                                                                  Text(
                                                                    controller
                                                                        .snapshotData2
                                                                        .productprice
                                                                        .toString(),
                                                                    style: GoogleFonts.ubuntu(
                                                                        color: HexColor(
                                                                            '#A5AAB7'),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Image(
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(Api
                                                                  .imageBaseUrl +
                                                              controller
                                                                  .snapshotData2
                                                                  .images
                                                                  .toString()),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else if (snapshot.hasError) {
                                          return Icon(Icons.error_outline);
                                        } else {
                                          return Loader();
                                        }
                                      }),
                                ),
                                MyFloatingActionButton(onPressed: () {
                                  Get.offNamed(sellProductsScreen, arguments: [
                                    controller.userdata,
                                    controller.resident
                                  ]);
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
