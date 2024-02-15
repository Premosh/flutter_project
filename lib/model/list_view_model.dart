import 'package:flutter/material.dart';

class ListViewModel{
  IconData? icon;
  String? title;
  double? revenue;

  ListViewModel({this.icon, this.title, this.revenue});
}
final List<ListViewModel> movieList = [
  ListViewModel(icon: Icons.add, title: 'Mean Girls', revenue: 6.9),
  ListViewModel(icon: Icons.add, title: 'The Beekeeper', revenue: 6.7),
  ListViewModel(icon: Icons.add, title: 'Wonka', revenue: 5.7),
  ListViewModel(icon: Icons.add, title: 'Migration', revenue: 4.9),
];