import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarfoodlion/screens/show_cart.dart';
import 'package:tarfoodlion/utility/my_constant.dart';
import 'package:tarfoodlion/utility/my_style.dart';
import 'package:tarfoodlion/utility/signout_process.dart';
import 'package:tarfoodlion/widget/show_card_shop.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
//field
  String nameUser;

  @override
  void initState() {
    super.initState();
    findUser();
    aboutNotification();
  }

  Future<Null> aboutNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    await firebaseMessaging.getToken().then((value) async{
      String token = value;
      print('token = $token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String id = preferences.getString('id');
      String url = '${MyConstant().domain}/tarfood/editTokenWhereId.php?isAdd=true&id=$id&Token=$token';

      await Dio().get(url);

    });
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser =
          preferences.getString('Name'); // ค่า name ต้องตรง กับ preference
    });
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            showCartMenu(),
            signoutMenu(),
          ],
        ),
      );

  ListTile signoutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('Sign Out และ กลับไปหาหน้าแรก'),
        onTap: () => signOutProcess(context),
      );

  ListTile showCartMenu() => ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text('แสดงตระกล้า'),
        subtitle: Text('แสดง รายการอาหาร ใน ตระกล้า'),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => ShowCart(),
          );
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('user.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        'Name Login',
        style: TextStyle(color: Colors.black),
      ),
      accountEmail:
          Text('Login', style: TextStyle(color: MyStyle().primaryColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'Main User' : '$nameUser login'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcess(context))
        ],
      ),
      drawer: showDrawer(),
      body: ShowCardShop(),
    );
  }
}
