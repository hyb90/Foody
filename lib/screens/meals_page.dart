import 'package:flutter/material.dart';
import 'package:foody/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MealsPage extends StatefulWidget {
  final List<Meals> meals;
  final String category;
  MealsPage({Key key, this.meals,this.category}) : super(key: key);
  @override
  _MealsPageState createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<String> fav=[];
  List<Meals> meals=[];
  bool loading=false;
  bool loadingF=false;
  checkAllFav()async{
    setState(() {
      loading=true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      fav=localStorage.getStringList('fav');
      if(fav==null){fav=[];}
      localStorage.setStringList('fav', fav);
      for (int i=0;i<widget.meals.length;i++) {
        widget.meals[i].favorite=false;
        checkFav(widget.meals[i]);
        meals.add(widget.meals[i]);
      }
      loading=false;
    });
  }
  addToFavorite(Meals m)async{
    setState(() {
      loadingF=true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      m.favorite=true;
      fav.add(m.id.toString());
      localStorage.setStringList('fav', fav);
      loadingF=false;
    });
  }
  checkFav(Meals m){
    if(fav!=null) {
      for (int i = 0; i < fav.length; i++) {
        if (m.id.toString() == fav[i]) {
          m.favorite = true;
        }
      }
    }
  }
  removeFromFavorite(Meals m)async{
    setState(() {
      loadingF=true;
      m.favorite=false;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    fav=localStorage.getStringList('fav');
    fav.removeWhere((item) => item == m.id.toString());
    localStorage.setStringList('fav', fav);
    setState(() {
      loadingF=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAllFav();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(widget.category, style: TextStyle(color: Colors.white),),
        ),
        body:loading==true?Center(child: Text('Loading'),)
            :GridView.count(
          crossAxisCount: 2,
          childAspectRatio: .9,
          children: List.generate(meals.length, (index) {
            return GestureDetector(
                onTap: () {
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
                            image: NetworkImage(meals[index].image),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Text(meals[index].name),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price: "+meals[index].price.toString()),
                            loadingF?CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),):
                            meals[index].favorite?
                            IconButton(icon: Icon(Icons.favorite,color: Colors.red,),onPressed:() {
                              removeFromFavorite(meals[index]);} ,):
                            IconButton(icon: Icon(Icons.favorite_border,color: Colors.red,),onPressed:() {
                              addToFavorite(meals[index]);},)
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          }),
        ),
      ),
    );
  }
}
