import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_weather_app/models/weather_locations.dart';
import 'package:my_weather_app/widgets/buildin_transform.dart';
import 'package:my_weather_app/widgets/single_weather.dart';
import 'package:my_weather_app/widgets/slider_dot.dart';


class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentpage = 0;
  late String bgImg;

  void _onPageChanged(int? index) {
    setState(() {
      _currentpage = index!;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(locationList[_currentpage].weatherType == 'Sunny'){
      bgImg = 'assets/sunny.jpg';
    }else if(locationList[_currentpage].weatherType == 'Night'){
      bgImg = 'assets/night.jpg';
    }else if(locationList[_currentpage].weatherType == 'Cloudy'){
      bgImg = 'assets/cloudy.jpeg';
    }else if(locationList[_currentpage].weatherType == 'Rainy') {
      bgImg = 'assets/rainy.jpg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => print("Menu Clicked!"),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              bgImg,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.only(top: 125, left: 15),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentpage)
                      SliderDot(isActive: true)
                    else
                      SliderDot(
                        isActive: false,
                      )
                ],
              ),
            ),
            TransformerPageView(
              scrollDirection: Axis.horizontal,
              transformer: ScaleAndFadeTransformer(),
              viewportFraction: 0.8,
              // onPageChanged: _onPageChanged,
              onPageChanged: _onPageChanged,
              itemCount: locationList.length,
              itemBuilder: (ctx, i) => SingleWeather(
                index: i,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

