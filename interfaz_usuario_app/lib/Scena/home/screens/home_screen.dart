import 'package:flutter/material.dart';

import '../widgets/item_selection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showTextField = false;
  int indexSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 65),
            margin: EdgeInsets.only(right: 29),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: _showTextField,
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Buscar...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showTextField = !_showTextField;
                    });
                  },
                  child: Icon(
                    _showTextField ? Icons.close : Icons.search_rounded,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 16),
            child: Text(
              'Work Place',
              style: TextStyle(
                fontFamily: 'Poppins ',
                fontStyle: FontStyle.normal,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 16),
            child: Text(
              'Choose your delicious meal ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 23,
          ),
          ItemSelection(
            indexSelection: indexSelection,
            height: 56,
            width: 62,
            onSelectIndex: (indexSeletion) {
              setState(() {
                this.indexSelection = indexSeletion;
              });
            },
          ),
        ],
      ),
    );
  }
}
