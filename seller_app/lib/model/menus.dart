import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuId;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;

  Menus(
      {this.menuId,
      this.sellerUID,
      this.menuTitle,
      this.menuInfo,
      this.publishedDate,
      this.thumbnailUrl,
      this.status});

  Menus.fromJson(Map<String, dynamic> json)
  {
    menuId = json["menuId"];
    sellerUID = json['sellerUID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["menuId"] = menuId;
    data['sellerUID'] = sellerUID;
    data['menuTitle'] = menuTitle;
    data['menuInfo'] = menuInfo;
    data['publishedDate'] = publishedDate;
    data['thumbnailUrl'] = thumbnailUrl;
    data['status'] = status;

    return data;
  }
}
