import 'package:flutter/material.dart';
import 'package:whatever/model/top_picks_model.dart';
import 'package:whatever/service/dio_service.dart';

class TopPicks extends StatelessWidget {
  const TopPicks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top picks'),
        centerTitle: true,
        actions: [
          GestureDetector(
              child: Icon(Icons.plus_one),
            onTap: (){
                final dioservice=DioService();
                dioservice.getSingleToDo();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: topPicksList.length,
          itemBuilder: (BuildContext context, int index) {
            final topPicksData = topPicksList[index];
            return Container(
              decoration: BoxDecoration(color: Colors.black26),
              child: Column(
                children: [
                  Image.network(topPicksData.url ??
                      'https://cdn1.vectorstock.com/i/1000x1000/50/20/no-photo-or-blank-image-icon-loading-images-vector-37375020.jpg'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${topPicksData.rating}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${topPicksData.title}'),
                ],
              ),
            );
          }),
    );
  }
}
