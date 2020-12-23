import 'package:flutter/material.dart';

//* this class implement the Bullets to represent
//* the state of the Purchase Flow receives 2 parameters
//* first one the LABEL to represent the name of state and
//* the second one represent the logical STATE of this label

class BulletList extends StatelessWidget {
  final String label;
  final bool enabled;

  const BulletList({
    Key key,
    this.label,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: enabled ? Colors.blue : Colors.white,
            boxShadow: [
              enabled
                  ? BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 4,
                      color: Colors.grey[500],
                    )
                  : BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 2,
                      color: Colors.grey[500],
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
