/// success : true
/// data : [{"id":1,"residentid":8,"societyid":1,"subadminid":2,"productname":"red chilli","description":"ahha","productprice":"200","images":"1684771298.jpg","created_at":"2023-05-22T16:01:38.000000Z","updated_at":"2023-05-22T16:01:38.000000Z"},{"id":2,"residentid":6,"societyid":1,"subadminid":2,"productname":"gg","description":"tt","productprice":"56","images":"1685100783.jpg","created_at":"2023-05-26T11:33:03.000000Z","updated_at":"2023-05-26T11:33:03.000000Z"},{"id":3,"residentid":7,"societyid":1,"subadminid":2,"productname":"qhuq","description":"hqh","productprice":"6446","images":"1685101981.jpg","created_at":"2023-05-26T11:53:01.000000Z","updated_at":"2023-05-26T11:53:01.000000Z"}]

class MarketPlace {
  MarketPlace({
    this.success,
    this.data,
  });

  MarketPlace.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;
  MarketPlace copyWith({
    bool? success,
    List<Data>? data,
  }) =>
      MarketPlace(
        success: success ?? this.success,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// residentid : 8
/// societyid : 1
/// subadminid : 2
/// productname : "red chilli"
/// description : "ahha"
/// productprice : "200"
/// images : "1684771298.jpg"
/// created_at : "2023-05-22T16:01:38.000000Z"
/// updated_at : "2023-05-22T16:01:38.000000Z"

class Data {
  Data({
    this.id,
    this.residentid,
    this.societyid,
    this.subadminid,
    this.productname,
    this.description,
    this.productprice,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    residentid = json['residentid'];
    societyid = json['societyid'];
    subadminid = json['subadminid'];
    productname = json['productname'];
    description = json['description'];
    productprice = json['productprice'];
    images = json['images'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? residentid;
  int? societyid;
  int? subadminid;
  String? productname;
  String? description;
  String? productprice;
  String? images;
  String? createdAt;
  String? updatedAt;
  Data copyWith({
    int? id,
    int? residentid,
    int? societyid,
    int? subadminid,
    String? productname,
    String? description,
    String? productprice,
    String? images,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        residentid: residentid ?? this.residentid,
        societyid: societyid ?? this.societyid,
        subadminid: subadminid ?? this.subadminid,
        productname: productname ?? this.productname,
        description: description ?? this.description,
        productprice: productprice ?? this.productprice,
        images: images ?? this.images,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['residentid'] = residentid;
    map['societyid'] = societyid;
    map['subadminid'] = subadminid;
    map['productname'] = productname;
    map['description'] = description;
    map['productprice'] = productprice;
    map['images'] = images;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
