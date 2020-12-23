import 'package:flutter/material.dart';

class TagPreco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.verified,
            color: Colors.white,
          ),
          Text(
            ' Melhor Preco ',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
