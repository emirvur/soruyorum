import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

/* 
todo 1. rnkler canlı olaiblir
*/
class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  SpinKitSquareCircle spinkit;

  @override
  void initState() {
    super.initState();

    spinkit = SpinKitSquareCircle(
      color: Colors.black87,
      size: 50.0,
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000)),
    );

    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.pushReplacementNamed(context, 'Signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/assets/lo.jpg'), fit: BoxFit.cover)),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              spinkit,
              //Image.asset('assets/images/flutterlogo.png', width: 40, height: 40,),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      "SOR-YOR",
                      style: GoogleFonts.nunito(fontSize: 30),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Yükleniyor",
                      style: GoogleFonts.nunito(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soryor/ui/signinscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  SpinKitSquareCircle spinkit;

  @override
  void initState() {
    super.initState();

    spinkit = SpinKitSquareCircle(
      color: Colors.black87,
      size: 50.0,
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000)),
    );

    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, 'SignIn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            spinkit,
            //Image.asset('assets/images/flutterlogo.png', width: 40, height: 40,),
            SizedBox(
              height: 25,
            ),
            Text(
              "Splash Screen",
              style: GoogleFonts.nunito(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
*/
