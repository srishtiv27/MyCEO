import 'constants.dart';

class Ceo {
  final String name;
  final String company;
  final String age;
  final String bio;
  final List<String> photos;
  final String id;
  Ceo({this.name, this.age, this.company, this.bio, this.photos, this.id});
}

List<Ceo> ceoInfo = [
  Ceo(
    name: 'Julie Sweet',
    company: 'Accenture',
    age: '52 years',
    bio: kJulieSweetBio,
    photos: [
      'images/julie-sweet.jpg',
      'images/julie-sweet2 .jpeg',
      'images/julie-sweet3.png',
    ],
    id: '0',
  ),
  Ceo(
    name: 'Elon Musk',
    company: 'SpaceX',
    age: '49 years',
    bio: kelonMuskBio,
    photos: [
      'images/elon-musk1.png',
      'images/elon-musk2.png',
      'images/elon-musk3.png',
    ],
    id: '1',
  ),
  Ceo(
    name: 'Mary Barra',
    company: 'General Motors',
    age: '58 years',
    bio: kmaryBarraBio,
    photos: [
      'images/mary-barra.png',
      'images/mary-barra2.jpg',
      'images/mary-barra3.png',
    ],
    id: '2',
  ),
  Ceo(
    name: 'Satya Nadella',
    company: 'Microsoft',
    age: '52 years',
    bio: ksatyaNadellaBio,
    photos: [
      'images/satyanadella1.png',
      'images/satyanadella2.png',
      'images/satyanadella1_2.png',
    ],
    id: '3',
  ),
];
