import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarfoodlion/model/order_model.dart';
import 'package:tarfoodlion/model/user_model.dart';
import 'package:tarfoodlion/utility/my_constant.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  List<OrderModel> orderModels = List();

  UserModel userModel;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');

    String url =
        '${MyConstant().domain}/tarfood/getOrderWhereIdShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(url).then((value) {
      print('res =################>>>>>> $value');
      var result = value.data;
      for (var map in result) {
        OrderModel model = OrderModel.fromJson(map);
        setState(() {
          orderModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return orderModels.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(itemCount: orderModels.length,
            itemBuilder: (context, index) => Text(orderModels[index].nameFood),
          );
  }
}
