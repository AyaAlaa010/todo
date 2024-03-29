
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bottom_sheet.dart';
import '../settings_providers.dart';

class LayoutView extends StatelessWidget {
  static String routeName = "LayoutView";

  LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: provider.getCurrentScreen(),
      extendBody: true,
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
      floatingActionButton:FloatingActionButton(onPressed: (){
            showModalBottomSheet(context: context,backgroundColor: Colors.transparent,
                builder: (context)=> TaskBottomSheet(),
            );
        },
        child: const Icon(Icons.add,color: Colors.white,size: 32,),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 12,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: BottomNavigationBar(
          currentIndex: provider.currentItemIndex,
          onTap: (index) {
            provider.setCurrentItemIndex(index);
          },
          items: [
            const BottomNavigationBarItem (
                icon:  Icon(
                  Icons.list,
                ),
                label: "tasks"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: "settings"),
          ],
        ),
      ),
    );
  }
}
