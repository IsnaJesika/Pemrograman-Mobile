import 'package:flutter/material.dart';
import 'package:flutter_stay/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void _navigateToAbout(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AboutPage(),
    ),
  );
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Stay Inn'),
        backgroundColor: Color.fromARGB(
                      255, 255, 189, 66),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stay Inn',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Stay Inn  aplikasi inovatif yang menyediakan solusi terpadu untuk menyewa apartemen dengan mudah dan efisien. Dibangun dengan teknologi terkini, STAIIN mempermudah pengguna dalam mencari, memilih, dan menyewa apartemen sesuai dengan kebutuhan dan preferensi mereka.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String name;
  final String address;
  final int age;
  final int hp;

  ProfilePage({
    required this.name,
    required this.age,
    required this.hp,
    required this.address,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
  class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(
                      255, 255, 189, 66),
        automaticallyImplyLeading: true,
      ),
      body: buildProfileBody(),
    );
  }

  Widget buildProfileBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/images/user1.png'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 40,
              child: ProfileMenu(
                icon: Icons.person,
                text: "My Account",
                press: () {
                  _navigateToEditProfile(context);
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 40,
              child: ProfileMenu(
                icon: Icons.info_outline,
                text: "About",
                press: () {
                  _navigateToAbout(context);
                },
                backgroundColor: Colors.orange, // Set the background color here
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 40,
              child: ProfileMenu(
                icon: Icons.logout_outlined,
                text: "Logout",
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                backgroundColor: Colors.orange, // Set the background color here
              ),
            ),
          ],
        ),
      ),
    );
  }


 void _navigateToAbout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutPage(),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialName: widget.name,
          initialAge: widget.age,
          initialHp: widget.hp,
          initialAdress: widget.address,
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback press;
  final Color backgroundColor; // New property for background color

  ProfileMenu({
    required this.icon,
    required this.text,
    required this.press,
    this.backgroundColor = Colors.orange, // Default background color
  });

 @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
      ),
      onPressed: press,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialAdress;
  final int initialAge;
  final int initialHp;

  EditProfilePage({
    required this.initialName,
    required this.initialAge,
    required this.initialHp,
    required this.initialAdress,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _hpController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _ageController = TextEditingController(text: widget.initialAge.toString());
    _addressController = TextEditingController(text: widget.initialAdress);
    _hpController = TextEditingController(
        text: widget.initialHp.toString().replaceAll(RegExp('^0+'), ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Color.fromARGB(
                      255, 255, 189, 66),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  name: _nameController.text,
                  age: int.parse(_ageController.text),
                  hp: int.parse(_hpController.text),
                  address: _addressController.text,
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                filled: true,
                fillColor: Colors.grey[200], // Warna latar belakang
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Usia',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _hpController,
              decoration: InputDecoration(
                labelText: 'No Handphone',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                _saveChanges();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                      255, 255, 189, 66), // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Simpan Perubahan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _saveChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', _nameController.text);
    prefs.setInt('age', int.parse(_ageController.text));
    prefs.setInt('hp', int.parse(_hpController.text));
    prefs.setString('address', _addressController.text);
  }
}
