import 'package:flutter/material.dart';
import 'package:flutter_stay/page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'bookmark_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StayInn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.transparent,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> promoImages = [
    'assets/images/user1.jpg',
    'assets/images/promo2.jpg',
    'assets/images/promo3.jpg',
  ];

  final List<String> apartmentImages = [
    'assets/images/apartment1.jpeg',
    'assets/images/apartment2.jpeg',
    'assets/images/apartment3.jpeg',
    // ... add more apartment images
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Promo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 200,
            child: PageView.builder(
              itemCount: promoImages.length,
              itemBuilder: (context, index) => Image.asset(
                promoImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Best Seller',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: apartmentImages.length,
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              color: Color.fromARGB(255, 255, 189, 66),  // Set the background color
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      apartmentImages[index],
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apartment ${index + 1}',  // Replace with actual descriptions
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Harga per Malam: Placeholder',  // Replace with actual prices
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isHomeIconPressed = true; // Initially set to true for the home icon
  bool _isBookmarkIconPressed = false;
  bool _isProfileIconPressed = false;
  final List<String> promoImages = [
    'assets/images/user1.jpeg',
    'assets/images/user2.jpeg',
    'assets/images/user3.jpeg',
  ];
  
  final List<Map<String, dynamic>> apartments = [
    {
      'image': 'assets/images/apartment1.jpeg',
      'description': 'Apartemen Margonda Residence 2 Tower HH Depok',
      'price': 'Rp 1.200.000',
      'facilities': ['AC', 'WiFi', 'Kamar mandi dalam'],
    },
    {
      'image': 'assets/images/apartment2.jpeg',
      'description':
          'Apartemen The Jarrdin Any Tower Any Floor Tipe 1BR 24 Bandung',
      'price': 'Rp 1.500.000',
      'facilities': ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
    },
    {
      'image': 'assets/images/apartment3.jpeg',
      'description':
          'Apartemen Lavande Residence Any Tower Any Floor Tipe 2BR 46 Surabaya',
      'price': 'Rp 1.800.000',
      'facilities': ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
    },
    {
      'image': 'assets/images/apartment6.jpeg',
      'description': 'Apartemen Alton recidence Tipe 1BR 32 Semarang',
      'price': 'Rp 1.200.000',
      'facilities': ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
    },
    {
      'image': 'assets/images/apartment5.jpeg',
      'description': 'Apartemen Vappe Flavoor 2BR 46 Bali',
      'price': 'Rp 1.900.000',
      'facilities': ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
    },
    {
      'image': 'assets/images/apartment4.jpeg',
      'description':
          'Apartemen Verde Residence Any Tower Any Floor Tipe 3BR 70 Jakarta',
      'price': 'Rp 2.000.000',
      'facilities': [
        'AC',
        'WiFi',
        'TV',
        'Kamar mandi dalam',
        'Kolam Renang',
        'Gym'
      ],
      'rating': 4.5,
    },
  ];

  List<Map<String, dynamic>> filteredApartments = [];

  @override
  void initState() {
    super.initState();
    filteredApartments = List.from(apartments);
  }

  void filterApartments(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredApartments = apartments
            .where((apartment) => apartment['description']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else {
        filteredApartments = List.from(apartments);
      }
    });
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('StayInn'),
      backgroundColor: Color.fromARGB(
                      255, 255, 189, 66),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: ApartmentSearch(
                apartmentList: apartments
                    .map<String>((apartment) =>
                        apartment['description'] as String)
                    .toList(),
                filterFunction: filterApartments,
              ),
            );
          },
        ),
      ],
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Best Seller",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: filteredApartments.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApartmentDetailPage(
                        imageUrl: filteredApartments[index]['image'],
                        apartmentDescription:
                            filteredApartments[index]['description'],
                        apartmentPrice:
                            filteredApartments[index]['price'],
                        apartmentFacilities:
                            filteredApartments[index]['facilities'],
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  color: Color.fromARGB(
                      255, 255, 189, 66), // Set the background color of the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          filteredApartments[index]['image'],
                          fit: BoxFit.cover,
                          height: 120,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          // Set the background color of the container to transparent
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredApartments[index]['description'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Harga per Malam: ${filteredApartments[index]['price']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
    bottomNavigationBar: BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: _isHomeIconPressed ? Colors.orange : Colors.black,
            onPressed: () {
              // Implement home button functionality
              setState(() {
                _isHomeIconPressed = true;
                _isBookmarkIconPressed = false;
                _isProfileIconPressed = false;
              });
            },
          ),
      IconButton(
        icon: Icon(Icons.bookmark),
        color: _isBookmarkIconPressed ? Colors.orange : Colors.black,
        onPressed: () {
          // Implement bookmark button functionality
          setState(() {
            _isHomeIconPressed = false;
            _isBookmarkIconPressed = true;
            _isProfileIconPressed = false;
            
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookmarkPage(),
                  ),
                );  
          });
        },
      ),
      IconButton(
        icon: Icon(Icons.person),
        color: _isProfileIconPressed ? Colors.orange : Colors.black,
        onPressed: () {
          // Implement profile button functionality
          setState(() {
            _isHomeIconPressed = false;
            _isBookmarkIconPressed = false;
            _isProfileIconPressed = true;
            print('Button Pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      name: 'Intan',
                      age: 19,
                      hp: 628586211900,
                      address: 'Semarang',
                    ),
                  ),
                );
          });
        },
      ),
    ],
  ),
),
        );
     
  }
}

// ... (kode sebelumnya)

class ApartmentDetailPage extends StatefulWidget {
  final String imageUrl;
  final String apartmentDescription;
  final String apartmentPrice;
  final List<String> apartmentFacilities;

  ApartmentDetailPage({
    Key? key,
    required this.imageUrl,
    required this.apartmentDescription,
    required this.apartmentPrice,
    required this.apartmentFacilities,
  }) : super(key: key);

  @override
  _ApartmentDetailPageState createState() => _ApartmentDetailPageState();
}

class _ApartmentDetailPageState extends State<ApartmentDetailPage> {
  DateTime? selectedDate;
  DateTime selectedTime = DateTime.now();
  bool isBookmarked = false;

  DateTime combineDateAndTime(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = combineDateAndTime(
            selectedDate!, DateTime(1, 1, 1, picked.hour, picked.minute));
      });
    }
  }

  Future<void> _updateBookmarkedApartments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedApartments =
        prefs.getStringList('bookmarkedApartments') ?? [];

    if (isBookmarked) {
      if (!bookmarkedApartments.contains(widget.apartmentDescription)) {
        bookmarkedApartments.add(widget.apartmentDescription);
      }
    } else {
      bookmarkedApartments.remove(widget.apartmentDescription);
    }

    await prefs.setStringList('bookmarkedApartments', bookmarkedApartments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Apartemen'),
        backgroundColor: Color.fromARGB(
                      255, 255, 189, 66),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.yellow : null,
            ),
            onPressed: () async {
              setState(() {
                isBookmarked = !isBookmarked;
              });
              await _updateBookmarkedApartments();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.apartmentDescription,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Harga per Malam: ${widget.apartmentPrice}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Fasilitas yang Tersedia:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.apartmentFacilities
                        .map((facility) => Text('- $facility'))
                        .toList(),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Pilih Tanggal Booking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(
                      255, 255, 189, 66),),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate != null
                                ? 'Tanggal: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Pilih Tanggal',
                          ),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Pilih Waktu Booking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(
                      255, 255, 189, 66),),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedTime != null
                                ? 'Waktu: ${selectedTime!.hour}:${selectedTime!.minute}'
                                : 'Pilih Waktu',
                          ),
                          Icon(Icons.access_alarm),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            apartmentName: widget.apartmentDescription,
                            totalPrice: widget.apartmentPrice,
                            paymentMethod: 'Metode Pembayaran',
                            selectedDate: selectedDate,
                            selectedTime: selectedTime,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // Warna latar belakang
                      ),
                      child: Text(
                        'Pembayaran',
                        style: TextStyle(color: Colors.white),
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final String apartmentName;
  final String totalPrice;
  final DateTime? selectedDate;
  final DateTime? selectedTime;
  final String paymentMethod;

  // Add an initializer to paymentMethod in the constructor
  const PaymentPage({
    Key? key,
    required this.apartmentName,
    required this.totalPrice,
    required this.selectedDate,
    required this.selectedTime,
    required String paymentMethod, // Initialize it here
  })  : paymentMethod = paymentMethod,
        super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentMethod = '';
  String bookingName = '';
  String phoneNumber = '';
  bool isPaymentSuccess = false;
  String barcode = '';

  Future<void> scanQRCode() async {
    final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Batal',
      true,
      ScanMode.QR,
    );

    setState(() {
      barcode = barcodeScanRes;
      isPaymentSuccess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        backgroundColor: Color.fromARGB(
                      255, 255, 189, 66),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(
                      255, 255, 189, 66),),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Tagihan:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDetailRow(
                            'Nama Apartemen : ', widget.apartmentName),
                        buildDetailRow('Total Tagihan : ', widget.totalPrice),
                        buildDetailRow(
                          'Tanggal Terpilih : ',
                          widget.selectedDate != null
                              ? '${widget.selectedDate!.day}-${widget.selectedDate!.month}-${widget.selectedDate!.year}'
                              : '',
                        ),
                        buildDetailRow(
                          'Waktu Terpilih : ',
                          widget.selectedTime != null
                              ? '${widget.selectedTime!.hour}:${widget.selectedTime!.minute}'
                              : '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildTextField(
                'Nama Pemboking',
                'Masukkan nama Anda',
                onChanged: (value) {
                  setState(() {
                    bookingName = value;
                  });
                },
              ),
              SizedBox(height: 16),
              buildTextField(
                'Nomor Telepon',
                'Masukkan nomor telepon Anda',
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              SizedBox(height: 14),
              Text(
                'Metode Pembayaran:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    paymentMethod = 'CASH';
                  });
                  scanQRCode();
                },
                child: Text('Bayar CASH'),
              ),
              SizedBox(height: 16),
              if (paymentMethod.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow('Kode Booking', 'abc321'),
                    SizedBox(height: 16),
                    if (isPaymentSuccess)
                      Column(
                        children: [
                          Text('Status Pembayaran: Sukses'),
                          SizedBox(height: 16),
                          buildQRCodeImage(),
                        ],
                      ),
                  ],
                ),
            ],
          )),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildTextField(
    String label,
    String hint, {
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildQRCodeImage() {
    return Image.network(
      'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$barcode',
      height: 150,
      width: 150,
    );
  }
}

class ApartmentSearch extends SearchDelegate<String> {
  final List<String> apartmentList;
  final Function(String) filterFunction;

  ApartmentSearch({
    required this.apartmentList,
    required this.filterFunction,
  });

  List<Map<String, dynamic>> filteredApartments = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    filterFunction(query);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: filteredApartments.length,
      itemBuilder: (context, index) {
        // Implementasi dari item dalam hasil pencarian
        return Container(); // Ganti dengan widget yang sesuai
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? apartmentList
        : apartmentList
            .where((apartment) =>
                apartment.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
