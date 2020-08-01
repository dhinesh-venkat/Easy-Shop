class Product {
  String itemId;
  String itemName;
  String code;
  String mrp;
  String costRate;
  String sellingRate;
  String uomId;
  String packingQty;
  String imageName;
  String subGroupId;
  String subGroup;
  String groupId;
  String groupName;
  String hsnId;
  String hsn;
  String narration;
  String createdOn;
  String updatedOn;

  Product({
    this.itemId,
    this.itemName,
    this.code,
    this.mrp,
    this.costRate,
    this.sellingRate,
    this.uomId,
    this.packingQty,
    this.imageName,
    this.subGroupId,
    this.subGroup,
    this.groupId,
    this.groupName,
    this.hsnId,
    this.hsn,
    this.narration,
    this.createdOn,
    this.updatedOn,
  });

  factory Product.fromJson(Map<String, dynamic> index) {
    return Product(
      itemId: index['ItemId'],
      itemName: index['ItemName'],
      code: index['Code'],
      mrp: index['MRP'],
      costRate: index['CostRate'],
      sellingRate: index['SellingRate'],
      uomId: index['UOMId'],
      packingQty: index['PacktingQty'],
      imageName: index['ImageName'],
      subGroupId: index['SubGroupId'],
      subGroup: index['SubGroup'],
      groupId: index['GroupId'],
      groupName: index['GroupName'],
      hsnId: index['HSNId'],
      hsn: index['HSN'],
      narration: index['Narration'],
      createdOn: index['CreatedOn'],
      updatedOn: index['UpdatedOn'],
    );
  }
}
