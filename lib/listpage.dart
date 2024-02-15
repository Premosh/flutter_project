import 'package:flutter/material.dart';
class List extends StatelessWidget {
  const List({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List_Page'),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrTFrhr_-pYR74jUgOy7IerAoHAX3zPIZZcg&usqp=CAU')
          ),
          SizedBox(
            height: 10,
          ),
          Title(
              color: Colors.black,
              child: Text('A Tiger',style: TextStyle(fontSize: 24),),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Nepal contains some of the most rugged and difficult mountain terrain in the world. Roughly 75 percent of the country is covered by mountains. From the south to the north, Nepal can be divided into four main physical belts, each of which extends east to west across the country. These are, first, the Tarai, a low, flat, fertile land adjacent to the border of India; second, the forested Churia foothills and the Inner Tarai zone, rising from the Tarai plain to the rugged Mahābhārat Range; third, the mid-mountain region between the Mahābhārat Range and the Great Himalayas; and, fourth, the Great Himalaya Range, rising to more than 29,000 feet (some 8,850 metres).'),
        ],
      )

    );
  }
}
