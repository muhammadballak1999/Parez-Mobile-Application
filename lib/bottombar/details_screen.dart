import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String content;
  DetailScreen(this.title, this.image, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.purple,
                Colors.deepPurple,
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: "Img",
              child: Image.network(
                image,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF1a1a1a),
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(content),
          ],
        ),
      ),
    );
  }
}
