import 'package:flutter/material.dart';
import 'package:whatever/model/list_view_model.dart';

class Listview extends StatelessWidget {
  const Listview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            final movieData=movieList[index];
            return ListTile(
              leading: Icon(movieData.icon),
              title: Text(
                movieData.title ?? 'Title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('\$ ${movieData.revenue} M'),
            );
          }),
    );
  }
}
