import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import pustaka intl

class Apartment {
  String? id;
  String? title;
  String? image;
  String? location;
  String? description;
  double? rating;
  int? price;
  String? type;
  int? users;
  List<String>? facilities;

  Apartment({
    this.description,
    this.facilities,
    this.id,
    this.image,
    this.location,
    this.price,
    this.rating,
    this.title,
    this.type,
    this.users,
  });

  String getFormattedPrice() {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatCurrency.format(price);
  }
}

final List<Apartment> listApartmentTop = [
  Apartment(
    description: 'An building',
    facilities: ['2 Bedrooms', '1 Toilet', '1 Living Room', '1 Kitchen'],
    id: 'apartment1',
    image: 'assets/images/apartment1.jpeg',
    location: 'Bali, Indonesia',
    price: 230,
    rating: 4.5,
    title: 'Town Hall',
    type: 'Hot this month',
    users: 13,
  ),
  Apartment(
    description:
        "An apartment is a private residence in a building or house that's divided into several separate dwellings. An apartment can be one small room or several. An apartment is a flat — it's usually a few rooms that you rent in a building.",
    facilities: ['2 Bedrooms', '1 Toilet', '1 Living Room', '1 Kitchen'],
    id: 'apartment2',
    image: 'assets/images/apartment2.jpeg',
    location: 'Garut, Indonesia',
    price: 173,
    rating: 4.5,
    title: 'Babakan Seungit',
    type: 'Great Place',
    users: 40,
  ),
];

final List<Apartment> listApartmentNear = [
  Apartment(
    description:
        "An apartment is a private residence in a building or house that's divided into several separate dwellings. An apartment can be one small room or several. An apartment is a flat — it's usually a few rooms that you rent in a building.",
    facilities: ['2 Bedrooms', '1 Toilet', '1 Living Room', '1 Kitchen'],
    id: 'apartment3',
    image: 'assets/images/apartment3.jpeg',
    location: 'Bandung, Indonesia',
    price: 221,
    rating: 4.5,
    title: 'Valley Mount',
    type: 'Pure',
    users: 39,
  ),
  Apartment(
    description:
        "An apartment is a private residence in a building or house that's divided into several separate dwellings. An apartment can be one small room or several. An apartment is a flat — it's usually a few rooms that you rent in a building.",
    facilities: ['2 Bedrooms', '1 Toilet', '1 Living Room', '1 Kitchen'],
    id: 'apartment4',
    image: 'assets/images/apartment4.jpeg',
    location: 'Garut, Indonesia',
    price: 180,
    rating: 4.5,
    title: 'Loa Uhuy',
    type: 'Pure',
    users: 21,
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apartments'),
      ),
      body: ListView.builder(
        itemCount: listApartmentTop.length,
        itemBuilder: (context, index) {
          Apartment apartment = listApartmentTop[index];
          return ListTile(
            title: Text(apartment.title!),
            subtitle: Text(
                apartment.getFormattedPrice()), // Tampilkan harga dalam Rupiah
            onTap: () {
              // Tambahkan navigasi ke halaman detail atau aksi lainnya di sini
            },
          );
        },
      ),
    );
  }
}
