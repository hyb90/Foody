import 'package:flutter/material.dart';
import 'package:foody/screens/cart_page.dart';
import 'categories_page.dart';
import 'meals_page.dart';
import 'package:flutter/cupertino.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int pageIndex=0;
  PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=PageController(initialPage: 0);
  }

  onPageChanged(int pageIndex){
    setState(() {
      this.pageIndex=pageIndex;
    });
  }
  onTap(int pageIndex){
    pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds:500 ),
        curve: Curves.easeInOut
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView(
          children: <Widget>[
            CategoriesPage(),
            CartPage(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.black.withOpacity(0.1),
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon:pageIndex!=0?Icon( Icons.store_outlined,color: Colors.black,):Icon( Icons.store_mall_directory,color: Colors.black,),),
            BottomNavigationBarItem(icon:pageIndex==1?Icon( Icons.shopping_bag_rounded,color: Colors.black,):Icon( Icons.shopping_bag_outlined,color: Colors.black,),),

          ],
        ),
      ),
    );

  }

}
