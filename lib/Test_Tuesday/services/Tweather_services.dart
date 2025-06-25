import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TweatherServices {
  Future<Tweather> getTweather(String place) async {
    try {
      final parameters = {
        'key': 'd93ccd9ed8f445ad82c112929240606',
        'q': place,
        'days': '7'
      };
      final uri =
          Uri.http('api.weatherapi.com', '/v1/forecast.json', parameters);

      var response = await http.get(uri);
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Tweather(
          location: data['location']['name'],
          condition: data['current']['condition']['text'],
          icon: data['current']['condition']['icon'],
          temperatureC: data['current']['temp_c'],
          temperatureF: data['current']['temp_f'],
          forecastHour: data['forecast']['forecastday'][0]['hour'],
          feelslikeC: data['current']['feelslike_c'],
        );
      } else {
        throw Exception('Unable to get Data from API');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class Tweather {
  final String location;
  final String condition;
  final double temperatureC;
  final double temperatureF;
  final String icon;
  final double feelslikeC;

  final dynamic forecastHour;
  Tweather({
    this.location = '',
    this.condition = 'Sunny',
    this.icon = '',
    this.temperatureC = 0,
    this.temperatureF = 0,
    this.feelslikeC = 0,
    this.forecastHour = "",
  });
}
