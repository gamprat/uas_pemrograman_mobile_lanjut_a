import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/cart_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartItem(
                      title: item['title'],
                      imagePath: item['imagePath'],
                      price: item['price'],
                      quantity: item['quantity'],
                      onRemove: () {
                        cart.removeItem(index);
                      },
                      onQuantityChanged: (quantity) {
                        cart.updateQuantity(index, quantity);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2)
                          .format(cart.totalPrice),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final totalFormatted = NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2)
                          .format(cart.totalPrice);
                      final message =
                          "Saya ingin membayar pesanan saya dengan total harga $totalFormatted";
                      final whatsappUrl =
                          "https://wa.me/62895413993376?text=${Uri.encodeComponent(message)}";

                      launchUrl(Uri.parse(whatsappUrl));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Check Out',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CartItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final double price;
  final int quantity;
  final VoidCallback onRemove;
  final ValueChanged<int> onQuantityChanged;

  CartItem({
    required this.title,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    String formattedPrice =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2)
            .format(price);

    return Card(
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50),
        title: Text(title),
        subtitle: Text('$formattedPrice x $quantity'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (quantity > 1) {
                  onQuantityChanged(quantity - 1);
                }
              },
            ),
            Text('$quantity'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                onQuantityChanged(quantity + 1);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red, // Menetapkan warna merah
              ),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
