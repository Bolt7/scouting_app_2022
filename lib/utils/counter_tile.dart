// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//copied increment decrement idea from stackoverflow, credit does to funder7
//https://stackoverflow.com/a/65271573

import 'package:flutter/material.dart';

class CounterTile extends StatelessWidget {
  final String label;
  final double scaleFactor;
  final int value;
  final ValueChanged<int> onIncrease;
  final ValueChanged<int> onDecrease;

  const CounterTile({
    required this.onIncrease,
    required this.onDecrease,
    this.label = "",
    this.scaleFactor = 1.0,
    this.value = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.remove,
                color: Theme.of(context).colorScheme.secondary,
              ),
              iconSize: 32.0 * scaleFactor,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                onDecrease(value);
              },
            ),
            Text(
              '$value',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0 * scaleFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.secondary,
              ),
              iconSize: 32.0 * scaleFactor,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                onIncrease(value);
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12 * scaleFactor),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18 * scaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
