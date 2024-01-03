import 'package:flutter/material.dart';

class SliverAppBarSection extends StatelessWidget {
  const SliverAppBarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 450.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/christmas-pavlova.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
