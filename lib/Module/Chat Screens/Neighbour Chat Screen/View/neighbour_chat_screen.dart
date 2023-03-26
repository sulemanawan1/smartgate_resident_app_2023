import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Constants/api_routes.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Widgets/Loader/loader.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../../Widgets/Empty List/empty_list.dart';
import '../Controller/neighbour_chat_screen_controller.dart';

class NeighbourChatScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NeighbourChatScreenController>(
        init: NeighbourChatScreenController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyBackButton(
                      text: '',
                      widget: Row(
                        children: [
                          SizedBox(
                            width: 2,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(imageBaseUrl +
                                controller.chatneighbours.image.toString()),
                            maxRadius: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                controller.chatneighbours.firstname.toString() +
                                    ' ' +
                                    controller.chatneighbours.lastname
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // ZegoUIKitPrebuiltCallWithInvitation(
                          //   ringtoneConfig: ZegoRingtoneConfig(),
                          //   events: ZegoUIKitPrebuiltCallInvitationEvents(
                          //
                          //     onIncomingCallTimeout: (String timeout, ZegoCallUser? calluser){
                          //
                          //       print(calluser!.name);
                          //       print(calluser!.id);
                          //     },
                          //     onIncomingCallAcceptButtonPressed: (){
                          //
                          //
                          //       print( "Call Accepted");
                          //     }
                          //
                          //
                          //   ),
                          //     appID:2104827868,
                          //     tokenServerUrl: "wss://webliveroom2104827868-api.coolzcloud.com/ws",
                          //     appSign:"0c362ea56d0f9f4a0d5114cb0c33a83989d9982d15450c866cecd91b810840b8",
                          //     userID:  controller.chatneighbours.id.toString(),
                          //     userName:controller.chatneighbours.firstname.toString(),
                          //     notifyWhenAppRunningInBackgroundOrQuit: true,
                          //     // isIOSSandboxEnvironment: false,
                          //     plugins: [ZegoUIKitSignalingPlugin()],
                          //   child: Container(),
                          //
                          //
                          //
                          //
                          // ),
                          //
                          //
                          // ZegoSendCallInvitationButton(
                          //   /// For offline call notification
                          //   ///
                          //   resourceID: "zegouikit_call",
                          //   icon: ButtonIcon(icon: Icon(Icons.video_call,color: Colors.white,)),
                          //
                          //   isVideoCall: true,
                          //   invitees: [
                          //     ZegoUIKitUser(
                          //         id: controller.userdata.userid.toString(),
                          //         name: controller.userdata.firstName.toString()
                          //     ),
                          //
                          //   ],
                          // ),
                          // ZegoSendCallInvitationButton(
                          //   /// For offline call notification
                          //   ///
                          //   resourceID: "zegouikit_call",
                          //   icon: ButtonIcon(icon: Icon(Icons.call,color: Colors.white),),
                          //
                          //   isVideoCall: false,
                          //   invitees: [
                          //     ZegoUIKitUser(
                          //         id: controller.userdata.userid.toString(),
                          //         name: controller.userdata.firstName.toString()
                          //     ),
                          //
                          //   ],
                          // ),

                          // GestureDetector(onTap: () {
                          //
                          //
                          //   Get.toNamed(audiocallscreen,arguments: [
                          //     controller.userdata,
                          //     controller.chatRoomid
                          //
                          //   ]);
                          //
                          // }, child: Icon(Icons.call,color: Colors.white,)),
                        ],
                      )),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder(
                          future: controller.ViewConversationNeighboursApi(
                              token: controller.userdata.bearerToken!,
                              chatroomid: controller.chatRoomid),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {

    if (snapshot.data != null && snapshot.data!.length != 0) {

    return ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        snapshot.data[index].sender ==
                                                controller.userdata.userid
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 16),
                                              decoration: BoxDecoration(
                                                color: snapshot.data[index]
                                                            .sender ==
                                                        controller
                                                            .userdata.userid
                                                    ? primaryColor
                                                    : Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                snapshot.data[index].message
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );}
    else { return  EmptyList(name: 'Say Hi ! to your Neighbour'); }
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return Loader();
                            }
                          }),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            controller: controller.msg,
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: () {
                              controller.conversationsApi(
                                  token: controller.userdata.bearerToken!,
                                  userid: controller.userdata.userid!,
                                  residentid:
                                      controller.chatneighbours.residentid!,
                                  message: controller.msg.text,
                                  chatroomid: controller.chatRoomid);
                            },
                            child: Icon(Icons.send)),
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
