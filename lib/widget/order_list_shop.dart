import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarfoodlion/model/order_model.dart';
import 'package:tarfoodlion/model/user_model.dart';
import 'package:tarfoodlion/utility/my_constant.dart';
import 'package:tarfoodlion/utility/my_style.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  List<OrderModel> orderModels = List();
  List<List<String>> listNameFoods = List();
  List<List<String>> listPriceFoods = List();
  List<List<String>> listAmountFoods = List();
  List<List<String>> listSumFoods = List();

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
      // print('res =################>>>>>> $value');
      var result = json.decode(value.data);
      for (var map in result) {
        OrderModel model = OrderModel.fromJson(map);

        String nameFoodArray = model.nameFood;
        nameFoodArray = nameFoodArray.substring(1, nameFoodArray.length - 1);
        List<String> nameFoods = nameFoodArray.split(',');

        String namePriceArray = model.price;
        namePriceArray = namePriceArray.substring(1, namePriceArray.length - 1);
        List<String> priceFoods = namePriceArray.split(',');

        String amoundFoodArray = model.amount;
        amoundFoodArray =
            amoundFoodArray.substring(1, amoundFoodArray.length - 1);
        List<String> amoundFoods = amoundFoodArray.split(',');

        String sumFoodArray = model.sum;
        sumFoodArray = sumFoodArray.substring(1, sumFoodArray.length - 1);
        List<String> sumFoods = sumFoodArray.split(',');

        setState(() {
          listSumFoods.add(sumFoods);
          listAmountFoods.add(amoundFoods);
          listPriceFoods.add(priceFoods);
          listNameFoods.add(nameFoods);
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
        : ListView.builder(
            itemCount: orderModels.length,
            itemBuilder: (context, index1) => Column(
              children: <Widget>[
                MyStyle().showTitle(orderModels[index1].nameUser),
                Row(
                  children: <Widget>[MyStyle().showTitleH2('Head')],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: listNameFoods.length,
                  itemBuilder: (context, index2) => Row(
                    children: <Widget>[
                      Expanded(flex: 3,
                        child: Text(listNameFoods[index1][index2]),
                      ),
                      Expanded(flex: 1,
                        child: Text(listPriceFoods[index1][index2]),
                      ),
                      Expanded(flex: 1,
                        child: Text(listAmountFoods[index1][index2]),
                      ),
                      Expanded(flex: 1,
                        child: Text(listSumFoods[index1][index2]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
