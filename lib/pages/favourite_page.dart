import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/favourite_model.dart';
import 'package:intl/intl.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favourites = Provider.of<FavouriteModel>(context).items;

    return Scaffold(
      body: ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          final item = favourites[index];
          return ListTile(
            leading: Image.asset(item['imagePath']),
            title: Text(item['title']),
            subtitle: Text(NumberFormat.currency(
                    locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2)
                .format(item['price'])),
          );
        },
      ),
    );
  }
}
