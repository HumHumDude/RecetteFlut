import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView(
            padding: const EdgeInsets.all(25),
            children: DUMMY_CATEGORIES
                .map(
                  (catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                  ),
                )
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        ),
        Container(
          height: 20,
          child: Text(
            'Made with love by Mohamed Jed Ben Njima',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
