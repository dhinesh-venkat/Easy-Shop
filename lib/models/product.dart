class Product {
  String itemId;
  String itemName;
  String hSN;
  String groupName;
  String groupId;
  String subGroupId;
  String imageName;
  List<Data> data;

  Product(
      {this.itemId,
      this.itemName,
      this.hSN,
      this.groupName,
      this.groupId,
      this.subGroupId,
      this.imageName,
      this.data});

  Product.fromJson(Map<String, dynamic> json) {
    itemId = json['ItemId'];
    itemName = json['ItemName'];
    hSN = json['HSN'];
    groupName = json['GroupName'];
    groupId = json['GroupId'];
    subGroupId = json['SubGroupId'];
    imageName = json['ImageName'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  String packingQty;
  String uOM;
  String uOMId;
  String sellingRate;
  String costRate;
  String mRP;
  String code;

  Data(
      {this.packingQty,
      this.uOM,
      this.uOMId,
      this.sellingRate,
      this.costRate,
      this.mRP,
      this.code});

  Data.fromJson(Map<String, dynamic> json) {
    packingQty = json['PackingQty'];
    uOM = json['UOM'];
    uOMId = json['UOMId'];
    sellingRate = json['SellingRate'];
    costRate = json['CostRate'];
    mRP = json['MRP'];
    code = json['Code'];
  }
}
