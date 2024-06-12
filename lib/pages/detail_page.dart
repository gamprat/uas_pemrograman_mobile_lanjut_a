import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/cart_model.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/favourite_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final double price;

  DetailPage({
    required this.title,
    required this.imagePath,
    required this.price,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    final favourites =
        Provider.of<FavouriteModel>(context, listen: false).items;
    isFavorite = favourites.any((item) => item['title'] == widget.title);
  }

  void _showBottomModal(BuildContext context, String action) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        int _quantity = 1;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        widget.imagePath,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: 4),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 2)
                                  .format(widget.price),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setModalState(() {
                                if (_quantity > 1) _quantity--;
                              });
                            },
                          ),
                          Text('$_quantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setModalState(() {
                                _quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (action == 'buy_now') {
                          final whatsappUrl =
                              "https://wa.me/62895413993376?text=${Uri.encodeComponent('Saya ingin pesan ${_quantity} ${widget.title} dengan harga ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(widget.price * _quantity)}')}";

                          launchUrl(Uri.parse(whatsappUrl));
                        } else {
                          Provider.of<CartModel>(context, listen: false)
                              .addItem(
                            widget.title,
                            widget.imagePath,
                            widget.price,
                            _quantity,
                          );

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Item added to cart!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      ),
                      child:
                          Text(action == 'buy_now' ? 'Buy Now' : 'Add to Cart'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedPrice =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2)
            .format(widget.price);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });

              if (isFavorite) {
                Provider.of<FavouriteModel>(context, listen: false).addItem(
                  widget.title,
                  widget.imagePath,
                  widget.price,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.title} added to favorites!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else {
                Provider.of<FavouriteModel>(context, listen: false)
                    .removeItem(widget.title);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.title} removed from favorites!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(widget.imagePath),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available in stock',
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
                Row(
                  children: [
                    Icon(Icons.star,
                        color: Color.fromARGB(255, 240, 225, 90), size: 24),
                    SizedBox(width: 4),
                    Text(
                      '4.6',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '(120 Reviews)',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              formattedPrice,
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              'Product info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The goods sold in this shop are guaranteed to be authentic.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _showBottomModal(context, 'add_to_cart');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              child: Icon(Icons.shopping_cart, color: Colors.red, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _showBottomModal(context, 'buy_now');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
