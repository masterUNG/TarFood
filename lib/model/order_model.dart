class OrderModel {
  String id;
  String idShop;
  String nameShop;
  String idUser;
  String nameUser;
  String nameFood;
  String price;
  String amount;
  String sum;
  String rider;
  String status;

  OrderModel(
      {this.id,
      this.idShop,
      this.nameShop,
      this.idUser,
      this.nameUser,
      this.nameFood,
      this.price,
      this.amount,
      this.sum,
      this.rider,
      this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    nameShop = json['NameShop'];
    idUser = json['idUser'];
    nameUser = json['NameUser'];
    nameFood = json['NameFood'];
    price = json['Price'];
    amount = json['Amount'];
    sum = json['Sum'];
    rider = json['Rider'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['NameShop'] = this.nameShop;
    data['idUser'] = this.idUser;
    data['NameUser'] = this.nameUser;
    data['NameFood'] = this.nameFood;
    data['Price'] = this.price;
    data['Amount'] = this.amount;
    data['Sum'] = this.sum;
    data['Rider'] = this.rider;
    data['Status'] = this.status;
    return data;
  }
}

