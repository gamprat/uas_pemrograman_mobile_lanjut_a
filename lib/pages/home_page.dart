import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/main.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/cart_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/detail_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/favourite_page.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/profil_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePageContent(),
    FavouritePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              },
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.red,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favourite"),
              selectedColor: Colors.red,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.red,
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
                  context, 'Accu (Aki)', 'assets/images/Aki.png', 250000, 4),
              _buildProductCard(
                  context, 'Busi', 'assets/images/Busi.png', 43500, 4),
              _buildProductCard(
                  context, 'Swingarm', 'assets/images/Swingarm.png', 345000, 4),
              _buildProductCard(context, 'Mangkok Ganda',
                  'assets/images/Mangkok Ganda.png', 82500, 4),
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
                context, 'Accu (Aki)', 'assets/images/Aki.png', 250000, 4),
            _buildProductCard(
                context, 'Busi', 'assets/images/Busi.png', 43500, 3),
            _buildProductCard(context, 'Ban Depan Vario 160',
                'assets/images/Ban Depan Vario 160.png', 333000, 5),
            _buildProductCard(context, 'Box Bagasi',
                'assets/images/Box Bagasi.png', 193000, 5),
            _buildProductCard(context, 'Cakram Depan Matic',
                'assets/images/Cakram Depan Matic.png', 161000, 5),
            _buildProductCard(
                context, 'Coolant', 'assets/images/Coolant.png', 19500, 5),
            _buildProductCard(context, 'Cover Knalpot',
                'assets/images/Cover Knalpot.png', 49500, 5),
            _buildProductCard(context, 'Engine Control Unit (ECU)',
                'assets/images/Engine Control Unit.png', 900000, 5),
            _buildProductCard(context, 'Fan Cover Comp',
                'assets/images/Fan Cover Comp.png', 20500, 5),
            _buildProductCard(
                context, 'Gear Comp', 'assets/images/Gear Comp.png', 209000, 5),
            _buildProductCard(context, 'Horn Comp (Klakson)',
                'assets/images/Horn Comp (Klakson).png', 57000, 5),
            _buildProductCard(context, 'Jok Vario 125',
                'assets/images/Jok Vario 125.png', 279500, 5),
            _buildProductCard(context, 'Kick Starter',
                'assets/images/Kick Starter.png', 81000, 5),
            _buildProductCard(context, 'Laher Bearing',
                'assets/images/Laher Bearing.png', 27000, 5),
            _buildProductCard(context, 'Lampu Sein',
                'assets/images/Lampu Sein.png', 136000, 5),
            _buildProductCard(context, 'Saringan Udara (Filter)',
                'assets/images/Saringan Udara (Filter).png', 51000, 5),
            _buildProductCard(context, 'Shock Breaker Belakang',
                'assets/images/Shock Breaker Belakang.png', 222500, 5),
            _buildProductCard(context, 'Speedometer Honda Vario 125',
                'assets/images/Speedometer Honda Vario 125.png', 547500, 5),
            _buildProductCard(
                context,
                'Stem Sub Assy Steering (Segitiga Depan)',
                'assets/images/Stem Sub Assy Steering (Segitiga Depan).png',
                487500,
                5),
            _buildProductCard(
                context, 'Swingarm', 'assets/images/Swingarm.png', 345000, 5),
            _buildProductCard(
                context, 'Spion', 'assets/images/Spion.png', 43000, 5),
            _buildProductCard(context, 'Tangki Bensin PCX 150',
                'assets/images/Tangki Bensin PCX 150.png', 267000, 5),
            _buildProductCard(
                context, 'Van Belt', 'assets/images/Van Belt.png', 109000, 5),
            _buildProductCard(context, 'Velg Belakang Vario 150',
                'assets/images/Velg Belakang Vario 150.png', 970000, 5),
          ],
        ),
      ],
    );
  }
}
