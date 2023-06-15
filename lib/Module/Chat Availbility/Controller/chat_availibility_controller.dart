import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/api_routes.dart';

import '../../Login/Model/User.dart';
import '../Model/ChatNeighbours.dart';
import '../Model/ChatRoomModel.dart';
import '../Model/ChatRoomUsers.dart';

class ChatAvailbilityController extends GetxController {
  late final User userdata;
  var resident;

  var data = Get.arguments;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata = data[0];
    resident = data[1];
  }

  Future<ChatNeighbours> viewChatNeighbours(
      {required int subadminid, required String token}) async {
    print(token);

    final response = await Http.get(
      Uri.parse(Api.chatNeighbours + "/" + subadminid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    ;

    if (response.statusCode == 200) {
      return ChatNeighbours.fromJson(data);
    }

    return ChatNeighbours.fromJson(data);
  }

  Future<ChatRoomModel> createChatRoomApi({
    required String token,
    required int userid,
    required int chatuserid,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.createChatRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "loginuserid": userid,
        "chatuserid": chatuserid,
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return ChatRoomModel.fromJson(data);
    } else {
      return ChatRoomModel.fromJson(data);
    }
  }

  Future<ChatRoomUsers> fetchchatroomusers(
      {required int userid,
      required int chatuserid,
      required String token}) async {
    final response = await Http.get(
      Uri.parse(Api.fetchChatroomUsers +
          "/" +
          userid.toString() +
          "/" +
          chatuserid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(data);

      return ChatRoomUsers.fromJson(data);
    }
    return ChatRoomUsers.fromJson(data);
  }

  Future<ChatRoomModel> fetchChatRoomApi(
      {required int userId,
      required int chatUserId,
      required String token}) async {
    final response = await Http.get(
      Uri.parse(Api.fetchChatRoom +
          "/" +
          userId.toString() +
          "/" +
          chatUserId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ChatRoomModel.fromJson(data);
    }
    return ChatRoomModel.fromJson(data);
  }
}
