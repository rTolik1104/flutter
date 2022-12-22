import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Demo Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _weather = "Pres the location button for get weather";

  var light = Colors.blue;

  var dark = Colors.grey;

  var _theme;

  void _incrementCounter() {
    setState(() {
      if(_counter<10){
        _counter++;
      }
    });
  }

  void _reduce(){
    setState(() {
      if(_theme == dark)
        _counter-=2;
      else
        _counter--;
    });
  }

  void _changeTheme(){
    setState(() {
      if(_theme == light)
        _theme = dark;
      else
        _theme = light;
    });
  }

  Future<void> _getWeather()  async {
    WeatherFactory wf = WeatherFactory('e3d8ef4e1011c6f8c932b347f6c064ae');
    String cityName = 'Tashkent';
    Weather w = await wf.currentWeatherByCityName(cityName);
    int? temp = w.temperature?.celsius?.ceil();
    String? desc = w.weatherDescription;
    setState(() {
      _weather = '$cityName,$temp`C, Weather: ${desc!}';
    });
    print(_weather);
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold = Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _weather
              ),
              const SizedBox(
                height: 40
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>
        [
          if(_counter < 10)
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          const SizedBox(
            height: 20,
          ),
          if(_counter>0)
            FloatingActionButton(
              onPressed: _reduce,
              tooltip: 'Reduce',
              child: const Icon(Icons.remove),
            ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              onPressed: _changeTheme,
              tooltip: 'Change theme',
              child: const Icon(Icons.palette),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: _getWeather,
            tooltip: 'Weather',
            child: const Icon(Icons.cloud),
          )
        ],
      ),
    );

    scaffold = Theme(
      data: ThemeData(
        textTheme: Theme.of(context).textTheme,
        scaffoldBackgroundColor: _theme,
      ),
      child: scaffold,
    );
    return scaffold;
  }
}
