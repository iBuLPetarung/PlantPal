import 'loginPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Color(0xFF0D4715))),
        backgroundColor: Color(0xFFEAF4E5),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D4715),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildProfileButton(
                context,
                "Login",
                FontAwesomeIcons.personChalkboard,
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
              ),
              _buildProfileButton(
                context,
                "Activity",
                FontAwesomeIcons.chartLine,
                () {
                  print("Activity Clicked");
                },
              ),
              _buildProfileButton(
                context,
                "Help Center",
                FontAwesomeIcons.circleInfo,
                () {
                  print("Help Center Clicked");
                },
              ),
              _buildProfileButton(
                context,
                "Change Language",
                FontAwesomeIcons.language,
                () {
                  print("Language Clicked");
                },
              ),
              _buildProfileButton(
                context,
                "Notification",
                FontAwesomeIcons.bell,
                () {
                  print("Notification Clicked");
                },
              ),
              _buildProfileButton(
                context,
                "Account Security",
                FontAwesomeIcons.shieldHalved,
                () {
                  print("Account Security Clicked");
                },
              ),
              _buildProfileButton(
                context,
                "Set up an account",
                FontAwesomeIcons.fileInvoice,
                () {
                  print("Set up an account Clicked");
                },
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Other Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D4715),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildProfileButton(
                context,
                "Privacy Policy",
                FontAwesomeIcons.handcuffs,
                () {
                  print("Privacy Policy Clicked");
                },
              ),
              _buildProfileButton(
                context,
                "Terms of Service",
                FontAwesomeIcons.teamspeak,
                () {
                  print("Terms of Service Clicked");
                },
              ),
              _buildProfileButton(context, "Rate", FontAwesomeIcons.star, () {
                print("Rate Clicked");
              }),
            ],
          ),
        ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AppEntry()),
                    );
                  },
                  icon: Icon(Icons.home, color: Color(0xFF0D4715), size: 30),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  icon: Icon(Icons.person, color: Color(0xFF0D4715), size: 30),
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
          child: Icon(Icons.local_florist, size: 32, color: Color(0xFFEAF4E5)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ButtonStyle getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    );
  }

  // Function to avoid repetition of button code
  Widget _buildProfileButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: getButtonStyle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Color(0xFF0D4715), size: 22),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF0D4715),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward, color: Color(0xFF0D4715), size: 24),
          ],
        ),
      ),
    );
  }
}
