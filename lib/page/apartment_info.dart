// apartment_info.dart
class ApartmentInfo {
  final String imageUrl;
  final String apartmentDescription;
  final String apartmentPrice;
  final List<String> apartmentFacilities;
  final double apartmentRating;

  ApartmentInfo({
    required this.imageUrl,
    required this.apartmentDescription,
    required this.apartmentPrice,
    required this.apartmentFacilities,
    required this.apartmentRating,
  });
}

List<ApartmentInfo> availableApartments = [
  ApartmentInfo(
    imageUrl: 'assets/images/apartment1.jpeg',
    apartmentDescription: 'Apartemen Margonda Residence 2 Tower HH Depok',
    apartmentPrice: 'Rp 1.200.000',
    apartmentFacilities: ['AC', 'WiFi', 'Kamar mandi dalam'],
    apartmentRating: 4.5,
  ),
  ApartmentInfo(
    imageUrl: 'assets/images/apartment2.jpeg',
    apartmentDescription:
        'Apartemen The Jarrdin Any Tower Any Floor Tipe 1BR 24 Bandung',
    apartmentPrice: 'Rp 1.500.000',
    apartmentFacilities: ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
    apartmentRating: 4.8,
  ),
  ApartmentInfo(
    imageUrl: 'assets/images/apartment3.jpeg',
    apartmentDescription:
        'Apartemen Lavande Residence Any Tower Any Floor Tipe 2BR 46 Surabaya',
    apartmentPrice: 'Rp 1.800.000',
    apartmentFacilities: ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
    apartmentRating: 4.3,
  ),
  ApartmentInfo(
    imageUrl: 'assets/images/apartment6.jpeg',
    apartmentDescription: 'Apartemen Alton recidence Tipe 1BR 32 Semarang',
    apartmentPrice: 'Rp 1.200.000',
    apartmentFacilities: ['AC', 'WiFi', 'TV', 'Kamar mandi dalam'],
    apartmentRating: 4.5,
  ),
  ApartmentInfo(
    imageUrl: 'assets/images/apartment5.jpeg',
    apartmentDescription: 'Apartemen Vappe Flavoor 2BR 46 Bali',
    apartmentPrice: 'Rp 1.900.000',
    apartmentFacilities: [
      'AC',
      'WiFi',
      'TV',
      'Kamar mandi dalam',
      'Kolam Renang'
    ],
    apartmentRating: 4.8,
  ),
  ApartmentInfo(
    imageUrl: 'assets/images/apartment4.jpeg',
    apartmentDescription:
        'Apartemen Verde Residence Any Tower Any Floor Tipe 3BR 70 Jakarta',
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
  ),
];
