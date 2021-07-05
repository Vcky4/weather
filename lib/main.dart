import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() => runApp(
    MaterialApp(
      title: "weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}

class HomeState extends State{
  var temp;
  var description;
  var currently;
  var windSpeed;
  var humidity;

  Future getWeather () async{
    http.Response response= await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=Uyo&units=imperial&APPID=23f80765824301c2657da73572c43a5c"));
        var results = jsonDecode(response.body);
        setState(() {
          this.temp = results['main']['temp'];
          this.description = results['weather'][0]['description'];
          this.currently = results['weather'][0]['main'];
          this.humidity = results['main']['humidity'];
          this.windSpeed = results['wind']['speed'];
        });
  }

  @override
  void initState (){
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Uyo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp != null? temp.toString()+"\u00B0" : "loading...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently!=null? currently.toString() : "loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp !=null? temp.toString() +"\u00B0" : "loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description!=null? description.toString() : "loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity!=null ? humidity.toString() : "loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind speed"),
                    trailing: Text(windSpeed!=null? windSpeed.toString() : "loading..."),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}