import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key? key,
    required this.field,
    required this.value,
  }) : super(key: key);

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(field, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
