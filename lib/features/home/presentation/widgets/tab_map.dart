import 'package:smart_voyageurs/features/home/presentation/fragment/draw_fragment.dart';
import 'package:smart_voyageurs/features/home/presentation/fragment/show_fragment.dart';
import 'package:smart_voyageurs/features/home/presentation/widgets/show_routes.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_voyageurs/core/ui/responsive_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TabMap extends StatefulWidget {
  @override
  _TabMapState createState() => _TabMapState();
}

class _TabMapState extends State<TabMap> with SingleTickerProviderStateMixin {


  TabController _controllerTab;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controllerTab = TabController(length: 2, vsync: this);

    _controllerTab.addListener(() {
      setState(() {
        _selectedIndex = _controllerTab.index;
      });
      print("Selected Index: " + _controllerTab.index.toString());
    });
  }
  

  @override
  void dispose() {
    _controllerTab?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Draw a route'),
          bottom: TabBar(
            controller: _controllerTab,
            onTap: (index) {

            },
            tabs: <Widget>[
              Tab(text: 'Draw polygons',),
              Tab(text: 'Show routes',),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controllerTab,
          children: <Widget>[
            DrawFragment(),
            ShowFragment(),
          ],
        ),
      ),
    );
  }

}


