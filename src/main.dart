import 'package:flutter/material.dart';
import 'package:productiv/src/view/app.dart';
import 'package:provider/provider.dart';

import 'model/auth/UserManager.dart';

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


