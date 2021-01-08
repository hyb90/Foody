import 'package:flutter/material.dart';
import 'package:foody/screens/meals_page.dart';
import 'package:foody/services/api.dart';
import 'package:foody/models/category.dart';
class CategoriesPage extends StatefulWidget {

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> categories;
  String error="";
  bool loading=false;
  getCategories() async {
    setState(() {
      error="";
      loading=true;
    });
    try{
      final cat = await Api.apiClient.getAllCategories();
      setState(() {
        loading=false;
        categories = cat;
      });
    }catch(e){
      setState(() {
        error=e.toString();
        loading=false;
      });

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Foody', style: TextStyle(color: Colors.white),),
      ),
      body:
      loading==true? Center(child: Text('Loading'),):error!=""?Center(child: Text(error),):GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .9,
        children: List.generate(categories.length, (index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => MealsPage(meals: categories[index].meals,category:categories[index].name,)));
              },
              child: Card(
                color: Colors.white.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(categories[index].image),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Text(categories[index].name)
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
