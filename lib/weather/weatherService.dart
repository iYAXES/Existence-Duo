import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherServices {
  Future<Weather> getWeatherData(String place) async {
    try {
      final parameters = {
        'key': 'd93ccd9ed8f445ad82c112929240606',
        'q': place,
        'days': '7',
      };
      final uri =
          Uri.http('api.weatherapi.com', '/v1/forecast.json', parameters);
      final response = await http.get(uri);
      Map<String, dynamic> json = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Weather(
          location: json['location']['name'],
          conditon: json['current']['condition']['text'],
          temperatureC: json['current']['temp_c'],
          heatlevel: json['current']['heatindex_c'],
          cloudlevel: json['current']['cloud'],
          forecasthour: json['forecast']['forecastday'][0]['hour'],
          forecastday: json['forecast']['forecastday'],
        );
      } else {
        throw Exception('Unable to get Weather Data');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class Weather {
  final String location;
  final String conditon;
  final double heatlevel;
  final int cloudlevel;
  final double temperatureC;

  final dynamic forecasthour;
  final dynamic forecastday;
  Weather({
    this.conditon = "Sunny",
    this.location = "",
    this.temperatureC = 0,
    this.heatlevel = 0,
    this.cloudlevel = 0,
    this.forecasthour = "",
    this.forecastday = "",
  });
}

class LocationName {
  final String name;
  LocationName({required this.name});
}
