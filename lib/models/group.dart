class Group {
  String id;
  String value;
  String imageUrl;

  Group({this.id, this.value, this.imageUrl});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    value = json['VALUE'];
    imageUrl = json['ImageName'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['ID'] = this.id;
  //   data['VALUE'] = this.value;
  //   data['ImageName'] = this.imageUrl;
  //   return data;
  // }
}
