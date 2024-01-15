import 'package:flutter/material.dart';
import 'package:flutter_stay/page/home_page.dart';
import 'package:flutter_stay/page/apartment_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<String> bookmarkedApartments = [];

  // List of ApartmentInfo instances
  List<ApartmentInfo> availableApartments = [
    // Your list of ApartmentInfo instances
  ];

  @override
  void initState() {
    super.initState();
    _loadBookmarkedApartments();
  }
// File: bookmark_page.dart

// ...

  void _loadBookmarkedApartments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarkedDescriptions =
        prefs.getStringList('bookmarkedApartments');

    if (bookmarkedDescriptions != null) {
      setState(() {
        bookmarkedApartments = bookmarkedDescriptions;
        // Update availableApartments based on bookmarkedApartments
        availableApartments = bookmarkedApartments.map((description) {
          switch (description) {
            case 'Apartemen Margonda Residence 2 Tower HH Depok':
              return ApartmentInfo(
                imageUrl: 'assets/images/apartment1.jpeg',
                apartmentDescription: description,
                apartmentPrice: 'Rp 1.200.000',
                apartmentFacilities: ['AC', 'WiFi', 'Kamar mandi dalam'],
                apartmentRating: 4.5,
              );
            case 'Apartemen The Jarrdin Any Tower Any Floor Tipe 1BR 24 Bandung':
              return ApartmentInfo(
                imageUrl: 'assets/images/apartment2.jpeg',
                apartmentDescription: description,
                apartmentPrice: 'Rp 1.500.000',
                apartmentFacilities: ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
                apartmentRating: 4.8,
              );
            case 'Apartemen Lavande Residence Any Tower Any Floor Tipe 2BR 46 Surabaya':
              return ApartmentInfo(
                imageUrl: 'assets/images/apartment3.jpeg',
                apartmentDescription: description,
                apartmentPrice: 'Rp 1.800.000',
                apartmentFacilities: ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
                apartmentRating: 4.3,
              );
            case 'Apartemen Alton recidence Tipe 1BR 32 Semarang':
              return ApartmentInfo(
                imageUrl: 'assets/images/apartment6.jpeg',
                apartmentDescription: description,
                apartmentPrice: 'Rp 1.200.000',
                apartmentFacilities: ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
                apartmentRating: 4.5,
              );
            case 'Apartemen Vappe Flavoor 2BR 46 Bali':
              return ApartmentInfo(
                imageUrl: 'assets/images/apartment5.jpeg',
                apartmentDescription: description,
                apartmentPrice: 'Rp 1.900.000',
                apartmentFacilities: [
                  'AC',
                  'WiFi',
                  'TV',
                  'Kamar mandi dalam',
                  'Kolam Renang',
                ],
                apartmentRating: 4.8,
              );
            case 'Apartemen Verde Residence Any Tower Any Floor Tipe 3BR 70 Jakarta':
              return ApartmentInfo(
                imageUrl: 'assets/images/apartment4.jpeg',
                apartmentDescription: description,
                apartmentPrice: 'Rp 2.000.000',
                apartmentFacilities: [
                  'AC',
                  'WiFi',
                  'TV',
                  'Kamar mandi dalam',
                  'Kolam Renang',
                  'Gym',
                ],
                apartmentRating: 4.5,
              );
            default:
              // You may want to handle other cases or throw an exception
              return ApartmentInfo(
                imageUrl: 'default_image_path',
                apartmentDescription: 'Unknown Apartment',
                apartmentPrice: 'Rp 0',
                apartmentFacilities: [],
                apartmentRating: 0.0,
              );
          }
        }).toList();
      });
    }
  }

// ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Apartments'),
      ),
      body: bookmarkedApartments.isEmpty
          ? Center(
              child: Text('No bookmarked apartments'),
            )
          : ListView.builder(
              itemCount: bookmarkedApartments.length,
              itemBuilder: (context, index) {
                final apartmentDescription = bookmarkedApartments[index];
                final apartmentInfo = availableApartments.firstWhere(
                  (info) => info.apartmentDescription == apartmentDescription,
                );

                return Dismissible(
                  key: Key(apartmentDescription),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    removeFromBookmarks(apartmentDescription);
                    setState(() {
                      bookmarkedApartments.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(apartmentInfo.apartmentDescription),
                    leading: Image.asset(
                      apartmentInfo.imageUrl,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeFromBookmarks(apartmentDescription);
                        setState(() {
                          bookmarkedApartments.removeAt(index);
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApartmentDetailPage(
                            imageUrl: apartmentInfo.imageUrl,
                            apartmentDescription:
                                apartmentInfo.apartmentDescription,
                            apartmentPrice: apartmentInfo.apartmentPrice,
                            apartmentFacilities:
                                apartmentInfo.apartmentFacilities,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  void removeFromBookmarks(String apartmentDescription) {
    // Implement the logic to remove the apartment from bookmarks
  }
}

// ignore: unused_element
class _ApartmentDetailPageState extends State<ApartmentDetailPage> {
  DateTime? selectedDate;
  bool isBookmarked = false;

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
  void initState() {
    super.initState();
    _loadBookmarkedStatus();
  }

  // Load bookmarked status from ApartmentInfo list
  void _loadBookmarkedStatus() async {
    List<String> bookmarkedApartments =
        await SharedPreferences.getInstance().then(
      (prefs) => prefs.getStringList('bookmarkedApartments') ?? [],
    );

    setState(() {
      isBookmarked = bookmarkedApartments.contains(widget.apartmentDescription);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Apartemen'),
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
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookmarkPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
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
                SizedBox(height: 16),
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
                SizedBox(height: 16),
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
                      border: Border.all(color: Colors.blue),
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
                SizedBox(height: 16),
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
                        ),
                      ),
                    );
                  },
                  child: Text('Pembayaran'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
