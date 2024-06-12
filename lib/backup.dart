import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPAREPART MOTOR HONDA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SPAREPART MOTOR HONDA',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
              // Tambahkan aksi yang ingin dilakukan ketika ikon keranjang belanja ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            _buildBanner(),
            _buildCarousel(),
            _buildFlashSaleSection(context),
            _buildBestForYouSection(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0), // Padding kanan kiri
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.red, // Ubah warna latar belakang menjadi merah
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/honda.png',
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayAnimationDuration: Durations.medium4,
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        'assets/images/slider/Coolant.png',
        'assets/images/slider/Roller.png',
        'assets/images/slider/Radiator.png',
        'assets/images/slider/Piston.png',
        'assets/images/slider/Spion.png',
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image.asset(i, fit: BoxFit.cover);
          },
        );
      }).toList(),
    );
  }

  Widget _buildFlashSaleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Flash Sale',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildProductCard(
                  context, 'Accue (Aki)', 'assets/images/Aki.png', 375000, 3),
              _buildProductCard(
                  context, 'Busi', 'assets/images/Busi.png', 375000, 4),
              _buildProductCard(
                  context, 'Swingarm', 'assets/images/Swingarm.png', 375000, 4),
              _buildProductCard(context, 'Mangkok Ganda',
                  'assets/images/Mangkok Ganda.png', 375000, 4),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, String title, String imagePath,
      double price, int rating) {
    String formattedPrice =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(price);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/productDetail',
          arguments: {
            'title': title,
            'imagePath': imagePath,
            'price': price,
          },
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        color: Colors.white,
        child: Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imagePath, height: 120, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Color.fromARGB(255, 211, 195, 50),
                      size: 16,
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    Text(formattedPrice, style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBestForYouSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Best For You',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Show All', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 0.55,
          children: [
            _buildProductCard(
                context, 'Accue (Aki)', 'assets/images/Aki.png', 250000, 4),
            _buildProductCard(
                context, 'Busi', 'assets/images/Busi.png', 250000, 3),
            _buildProductCard(context, 'Ban Depan Vario 160',
                'assets/images/Ban Depan Vario 160.png', 50000, 5),
            _buildProductCard(context, 'Box Bagasi',
                'assets/images/Box Bagasi.png', 50000, 5),
            _buildProductCard(context, 'Cakram Depan Matic',
                'assets/images/Cakram Depan Matic.png', 50000, 5),
            _buildProductCard(
                context, 'Coolant', 'assets/images/Coolant.png', 50000, 5),
            _buildProductCard(context, 'Cover Knalpot',
                'assets/images/Cover Knalpot.png', 50000, 5),
            _buildProductCard(context, 'Engine Control Unit (ECU)',
                'assets/images/Engine Control Unit.png', 50000, 5),
            _buildProductCard(context, 'Fan Cover Comp',
                'assets/images/Fan Cover Comp.png', 50000, 5),
            _buildProductCard(
                context, 'Gear Comp', 'assets/images/Gear Comp.png', 50000, 5),
            _buildProductCard(context, 'Horn Comp (Klakson)',
                'assets/images/Horn Comp (Klakson).png', 50000, 5),
            _buildProductCard(context, 'Jok Vario 125',
                'assets/images/Jok Vario 125.png', 50000, 5),
            _buildProductCard(context, 'Kick Starter',
                'assets/images/Kick Starter.png', 50000, 5),
            _buildProductCard(context, 'Laher Bearing',
                'assets/images/Laher Bearing.png', 50000, 5),
            _buildProductCard(context, 'Lampu Sein',
                'assets/images/Lampu Sein.png', 50000, 5),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping),
          label: 'Tracking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
    );
  }
}
