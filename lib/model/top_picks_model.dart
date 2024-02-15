import 'package:flutter/material.dart';

class TopPicksModel {
  String? title;
  IconData? icon;
  String? url;
  double? rating;

  TopPicksModel({this.title, this.icon, this.url, this.rating});
}

final List<TopPicksModel> topPicksList = [
  TopPicksModel(
      title: 'Beekeeper',
      icon: Icons.star_border,
      url: 'https://i.ibb.co/XVYT7M7/movie1.jpg',
      rating: 6.6),
  TopPicksModel(
      title: 'Mean Girls',
      icon: Icons.star_border,
      url: 'https://i.ibb.co/QCT5fMF/movie2.jpg',
      rating: 7.1),
  TopPicksModel(
      title: 'Love Lies Bleeding',
      icon: Icons.star_border,
      url: 'https://i.ibb.co/TbJ9cwZ/movie3.jpg',
      rating: 6.8),
];
