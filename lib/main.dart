import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/home_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/edit_profile.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/favourite_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/profil_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/cart_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/detail_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/cart_model.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/favourite_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => FavouriteModel()),
      ],
      child: SparepartMotorApp(),
    ),
  );
}

class SparepartMotorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sparepart Motor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        '/cart': (context) => CartPage(),
        '/favourite': (context) => FavouritePage(),
        '/profile': (context) => ProfilePage(),
        '/edit': (context) => EditProfilePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/productDetail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return DetailPage(
                title: args['title'],
                imagePath: args['imagePath'],
                price: args['price'],
              );
            },
          );
        }
        return null;
      },
    );
  }
}
