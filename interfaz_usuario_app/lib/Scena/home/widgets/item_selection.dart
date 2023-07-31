import 'package:flutter/material.dart';

import '../../widgets/item_icon.dart';

class ItemSelection extends StatefulWidget {
  int indexSelection;
  double height;
  double width;
  Function(int) onSelectIndex;
  ItemSelection({
    Key? key,
    required this.indexSelection,
    required this.height,
    required this.width,
    required this.onSelectIndex,
  }) : super(key: key);

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            widget.onSelectIndex(0);
          },
          child: ItemIcon(
            activeColor: Colors.black,
            desactiveColor: Colors.grey,
            isActive: widget.indexSelection == 0,
            icon: Icons.home,
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.onSelectIndex(1);
          },
          child: ItemIcon(
            activeColor: Colors.black,
            desactiveColor: Colors.grey,
            isActive: widget.indexSelection == 1,
            icon: Icons.favorite,
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.onSelectIndex(2);
          },
          child: ItemIcon(
            activeColor: Colors.black,
            desactiveColor: Colors.grey,
            isActive: widget.indexSelection == 2,
            icon: Icons.panorama_vertical_select_outlined,
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.onSelectIndex(3);
          },
          child: Container(
            margin: EdgeInsets.only(right: 18),
            child: ItemIcon(
              activeColor: Colors.black,
              desactiveColor: Colors.grey,
              isActive: widget.indexSelection == 3,
              icon: Icons.shopping_cart,
            ),
          ),
        ),
      ],
    );
  }
}
