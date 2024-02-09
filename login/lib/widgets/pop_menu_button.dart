import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class CustomPopMenuButton extends StatefulWidget {
  const CustomPopMenuButton({super.key});

  @override
  State<CustomPopMenuButton> createState() => _CustomPopMenuButtonState();
}

class _CustomPopMenuButtonState extends State<CustomPopMenuButton> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton<SampleItem>(
        initialValue: selectedMenu,
        // Callback that sets the selected popup menu item.
        onSelected: (SampleItem item) {
          setState(() {
            selectedMenu = item;
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemOne,
            child: Text('Item 1'),
          ),
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemTwo,
            child: Text('Item 2'),
          ),
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemThree,
            child: Text('Item 3'),
          ),
        ],
      ),
    );
  }
}
