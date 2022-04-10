import 'package:flutter/material.dart';

/*

my changes:
- add and implement scaleFactor
- Adjust styling
- Add starting value (fix)
*/
class NumericStepButton extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final double scaleFactor;

  final ValueChanged<int> onIncrease;
  final ValueChanged<int> onDecrease;

  const NumericStepButton({
    Key? key,
    this.minValue = 0,
    this.maxValue = 10,
    this.value = 0,
    this.scaleFactor = 1,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
