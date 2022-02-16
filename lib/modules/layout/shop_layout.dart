import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login_screen.dart';

import '../../shared/network/local/cashe_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TextButton(
        child: Text('Sign Out'),
        onPressed: () {
          CasheHelper.removeData(key: 'token').then((value) {
            if (value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          });
        },
      ),
    );
  }
}
