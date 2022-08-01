import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {

final String id;
final String title;
MovieDetail({Key key,@required this.id,@required this.title}) : super(key:key);


  @override
  _MovieDetailState createState() {
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    // return Text('detail---${widget.id}');
    // return Text('detail---' + widget.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Text('电影Id为：' + widget.id),
    );
  }
}