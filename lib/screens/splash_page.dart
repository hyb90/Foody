import 'package:flutter/material.dart';
import 'package:foody/screens/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 3500), vsync: this);
    opacity = Tween<double>(begin: 0.5, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Opacity(
                    opacity: opacity.value,
                    child: Text('Foody',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 50),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Powered by '),
                      TextSpan(
                          text: 'Humam Y Albitar',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
