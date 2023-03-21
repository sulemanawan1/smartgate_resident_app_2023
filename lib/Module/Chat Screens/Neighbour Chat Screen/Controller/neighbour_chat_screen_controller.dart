import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_callkit_incoming/entities/android_params.dart';
// import 'package:flutter_callkit_incoming/entities/call_event.dart';
// import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:pusher_client/pusher_client.dart';

import '../../../../Constants/api_routes.dart';
import '../../../../main.dart';

import '../../../Chat Availbility/Model/ChatNeighbours.dart' as ChatNeighbours;
import '../../../Chat Availbility/Model/ChatRoomModel.dart';
import '../../../HomeScreen/Model/residents.dart';
import '../../../Login/Model/User.dart';

import '../Model/ViewConversationNeighbours.dart';

class NeighbourChatScreenController extends GetxController {
  var data = Get.arguments;
  final ScrollController sc = ScrollController();
  late final User userdata;
  late final ChatRoomModel chatRoomModel;
  late int chatRoomid;
  bool isChat = false;
  late final Residents resident;
  bool isSend=false;

  List<ViewConversationNeighbours> v = [];
  final TextEditingController msg = TextEditingController();
  late final ChatNeighbours.Data chatneighbours;
  StreamController<List<ViewConversationNeighbours>>conversationneighboursstreamController =
      StreamController<List<ViewConversationNeighbours>>();

  Future<void> _initiatePusherSocketForMessaging() async {
    pusher = PusherClient(
        YOUR_APP_KEY,
        PusherOptions(
          host: 'http://192.168.10.3:8000',
          cluster: 'ap2',
          auth: PusherAuth(
            'http://192.168.10.3:8000',
            headers: {
              'Authorization': 'Bearer ${userdata.bearerToken}',
              'Content-Type': 'application/json'
            },
          ),
        ),
        autoConnect: false);

    pusher.connect();

    pusher.onConnectionStateChange((state) {
      print(
          "previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });

    pusher.onConnectionError((error) {
      print("error: ${error!.message}");
    });

    Channel channel = pusher.subscribe('my-channel');

    channel.bind('my-event', (PusherEvent? event) {
      // print('event data: ' + event!.data.toString());

      update();
      var data = jsonDecode(event!.data.toString());

      v.add(ViewConversationNeighbours(
          sender: data['message']['sender'],
          reciever: data['message']['reciever'],
          lastmessage: data['message']['lastmessage'],
          chatroomid: data['message']['chatroomid'],
          created_at: data['message']['created_at'],
          message: data['message']['message'],
          success: data['message']['success'],
          updated_at: data['message']['updated_at']));

      conversationneighboursstreamController.sink.add(v);

      update();
    });
  }






  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata = data[0];
    resident = data[1];
    chatneighbours = data[2];
    chatRoomid=data[3];
    _initiatePusherSocketForMessaging();
    update();






  }



  Future<List<ViewConversationNeighbours>> ViewConversationNeighboursApi(
      {required int chatroomid,
      required String token}) async {
    print(token);

    final response = await Http.get(
      Uri.parse(Api.viewconversationsneighbours +
          "/" +
          chatroomid.toString() ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    ;

    if (response.statusCode == 200) {


      v = (data['data'] as List)
          .map((e) => ViewConversationNeighbours(
              lastmessage: e['lastmessage'],
              sender: e['sender'],
              reciever: e['reciever'],
              chatroomid: e['chatroomid'],
              created_at: e['created_at'],
              message: e['message'],
              success: e['success'],
              updated_at: e['updated_at']))
          .toList();

      conversationneighboursstreamController.sink.add(v);




      return v;
    }
    v = (data as List)
        .map((e) => ViewConversationNeighbours(
            sender: e['sender'],
            reciever: e['reciever'],
            lastmessage: e['lastmessage'],
            chatroomid: e['chatroomid'],
            created_at: e['created_at'],
            message: e['message'],
            success: e['success'],
            updated_at: e['updated_at']))
        .toList();
    conversationneighboursstreamController.sink.add(v);

    update();



    return v;
  }

  Future conversationsApi({
    required String token,
    required int userid,
    required int residentid,
    required int chatroomid,
    required String message,
  }) async {
    print(userid);
    print(residentid);
    msg.text = '';
    final response = await Http.post(
      Uri.parse(Api.conversations),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "sender": userid,
        "reciever": residentid,
        "chatroomid": chatroomid,
        "message": message,
      }),
    );
    print(response.body);



    if (response.statusCode == 200) {


      isSend=true;

      // sc.position.animateTo(
      //   sc.position.maxScrollExtent,
      //   duration: const Duration(microseconds: 1),
      //   curve: Curves.fastOutSlowIn,
      // );
update();


    } else {
      Get.snackbar("Failed to send msg", "");
    }
  }


  Future<ChatRoomModel> createChatRoomApi({
    required String token,
    required int userid,
    required int chatuserid,



  }) async {
    final response = await Http.post(
      Uri.parse(Api.createchatroom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>
      {
        "loginuserid": userid,
        "chatuserid": chatuserid,


      }

      ),
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);


      return ChatRoomModel.fromJson(data);

    } else {
      return ChatRoomModel.fromJson(data);
    }
  }


}
