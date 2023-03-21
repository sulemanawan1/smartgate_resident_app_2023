import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../Constants/api_routes.dart';
import '../../../Constants/constants.dart';
import '../../../Widgets/Loader/loader.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../Controller/discussion_form_controller.dart';

class DiscussionForm extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscussionFormController>(
        init: DiscussionFormController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: Column(

                children: [
                  MyBackButton(
                      text: 'Discussion Form',
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: controller.getData().length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment:
                           controller.v[index].sender ==
                                1
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child:
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 16),
                                      decoration: BoxDecoration(
                                        color: controller.v[index]
                                            .sender ==
                                            1
                                            ? primaryColor
                                            : Colors.black,
                                        borderRadius:
                                        BorderRadius.circular(4),
                                      ),
                                      child:              controller.v[index]
                              .sender ==
                          1?   Text(
                                        controller.v[index].message
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white),
                                      ):Column(
                                        children: [
                                          Text(
                                            controller.v[index].created_at
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),

                                          Text(
                                            controller.v[index].message
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          );
                        },

                    ))
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
                              // controller.conversationsApi(
                              //     token: controller.userdata.bearerToken!,
                              //     userid: controller.userdata.userid!,
                              //     residentid:
                              //     controller.chatneighbours.residentid!,
                              //     message: controller.msg.text,
                              //     chatroomid: controller.chatRoomid!);
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
