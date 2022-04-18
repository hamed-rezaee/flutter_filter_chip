import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> _selectedCategory = <Category>[];

  final List<Item> _items = <Item>[
    Item('Cup', [Category.lowPrice, Category.highRate]),
    Item('Coffee', [Category.lowPrice, Category.lowRate]),
    Item('Tea', [Category.lowPrice]),
    Item('Table', [Category.highPrice, Category.highRate]),
    Item('Chair', [Category.highPrice]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Wrap(
            spacing: 8,
            children: Category.values
                .map(
                  (Category category) => FilterChip(
                    elevation: 2,
                    label: Text(
                      category.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    selected: _selectedCategory.contains(category),
                    selectedColor: Colors.blue,
                    checkmarkColor: Colors.white,
                    onSelected: (bool selected) {
                      selected
                          ? _selectedCategory.add(category)
                          : _selectedCategory.remove(category);

                      setState(() {});
                    },
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getItems(_items).length,
              itemBuilder: (BuildContext context, int index) {
                final Item item = _getItems(_items)[index];

                return ListTile(
                  title: Text(item.name),
                  subtitle: Row(
                    children: item.categories
                        .map((element) =>
                            Text('| ${element.name.toUpperCase()} |'))
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Item> _getItems(List<Item> items) => items
      .where((item) => _selectedCategory
          .any((category) => item.categories.contains(category)))
      .toList();
}

class Item {
  Item(this.name, this.categories);

  final String name;
  final List<Category> categories;
}

enum Category {
  highPrice,
  lowPrice,
  highRate,
  lowRate,
}
