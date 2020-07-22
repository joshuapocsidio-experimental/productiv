import 'package:flutter/material.dart';
import 'package:productiv/model/auth/UserManager.dart';
import 'package:productiv/view/app.dart';
import 'package:provider/provider.dart';

import 'model/user/User.dart';

void main() async
{
  UserManager userManager = new UserManager();
  await userManager.initManager();
  runApp(
    MultiProvider(
      child: ProductivApp(),
      providers: [
        ChangeNotifierProvider.value(
          value: userManager,
        ),
      ],
    ),
  );
}


