import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'splashScreen.dart';
import 'notificationPage.dart';
import 'profilePage.dart';
import 'menuPage.dart';
import 'chatBotPage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Inisialisasi Firebase
  runApp(AppEntry());
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  _AppEntryState createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  bool _isSplashDone = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          _isSplashDone
              ? MyApp()
              : SplashScreen(
                onFinish: () {
                  setState(() {
                    _isSplashDone = true;
                  });
                },
              ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageController _pageController = PageController();
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage++;
          if (_currentPage > 2) {
            _currentPage = 0;
          }
        });
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 237,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: [
                            Image.asset(
                              'assets/appBar1.jpeg',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/appBar2.jpeg',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/appBar3.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildKategoriTile(
                            "Vegetables",
                            FontAwesomeIcons.carrot,
                          ),
                          SizedBox(width: 10),
                          buildKategoriTile("Fruits", FontAwesomeIcons.apple),
                          SizedBox(width: 10),
                          buildKategoriTile(
                            "Grains",
                            FontAwesomeIcons.seedling,
                          ),
                          SizedBox(width: 10),
                          buildKategoriTile("Nuts", Icons.grain),
                        ],
                      ),
                      SizedBox(height: 26),
                      SizedBox(
                        width: 333,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () {
                            print("Start Plant clicked");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEAF4E5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_florist,
                                    color: Color(0xFF0D4715),
                                    size: 26,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Start Plant",
                                    style: TextStyle(
                                      color: Color(0xFF0D4715),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF0D4715),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      SizedBox(
                        width: 333,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ChatPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEAF4E5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.robot,
                                    color: Color(0xFF0D4715),
                                    size: 22,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Ask Planty",
                                    style: TextStyle(
                                      color: Color(0xFF0D4715),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF0D4715),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 36),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            'For you',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            12,
                            (index) => Container(
                              height: 100,
                              color:
                                  Colors.green[(index % 4 + 5) * 100] ??
                                  Colors.green,
                              child: Center(child: Text('Item ${index + 1}')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 32,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Expanded(child: _buildFloatingSearchBar()),
                  SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          spreadRadius: 3,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF0D4715),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            elevation: 16,
            color: Color(0xFFEAF4E5),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      print("Home clicked");
                    },
                    icon: Icon(Icons.home, color: Color(0xFF0D4715), size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFF0D4715),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            onPressed: () {
              print("Flower icon clicked");
            },
            backgroundColor: Color(0xFF99BC85),
            shape: CircleBorder(),
            child: Icon(
              Icons.local_florist,
              size: 32,
              color: Color(0xFFEAF4E5),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildFloatingSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF0D4715)),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Plant...',
                  hintStyle: TextStyle(color: Color(0xFF0D4715)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildKategoriTile(String title, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuPage(category: title)),
          );
        },
        child: _buildKategoriItem(
          title,
          Color(0xFFEAF4E5),
          icon,
          isClickable: true,
        ),
      ),
    );
  }

  Widget _buildKategoriItem(
    String title,
    Color color,
    IconData icon, {
    bool isClickable = false,
  }) {
    return Column(
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(51),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Color(0xFF99BC85), size: 28),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF0D4715),
          ),
        ),
      ],
    );
  }
}
