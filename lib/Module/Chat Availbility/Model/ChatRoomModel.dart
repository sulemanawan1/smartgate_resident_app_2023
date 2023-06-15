/// data : [{"loginuserid":1,"chatuserid":6,"updated_at":"2023-05-27T08:55:39.000000Z","created_at":"2023-05-27T08:55:39.000000Z","id":20}]

class ChatRoomModel {
  ChatRoomModel({
    this.data,
  });

  ChatRoomModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;
  ChatRoomModel copyWith({
    List<Data>? data,
  }) =>
      ChatRoomModel(
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// loginuserid : 1
/// chatuserid : 6
/// updated_at : "2023-05-27T08:55:39.000000Z"
/// created_at : "2023-05-27T08:55:39.000000Z"
/// id : 20

class Data {
  Data({
    this.loginuserid,
    this.chatuserid,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(dynamic json) {
    loginuserid = json['loginuserid'];
    chatuserid = json['chatuserid'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? loginuserid;
  int? chatuserid;
  String? updatedAt;
  String? createdAt;
  int? id;
  Data copyWith({
    int? loginuserid,
    int? chatuserid,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) =>
      Data(
        loginuserid: loginuserid ?? this.loginuserid,
        chatuserid: chatuserid ?? this.chatuserid,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['loginuserid'] = loginuserid;
    map['chatuserid'] = chatuserid;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}
