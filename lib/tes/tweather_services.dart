import 'package:http/http.dart';
import 'dart:convert' as convert;

class tWeatherServices {
  Future<tWeather> gettWeatherData(String place) async {
    try {
      final parameters = {
        'key': 'd93ccd9ed8f445ad82c112929240606',
        'q': place,
        'days': '7',
      };
      final uri =
          Uri.http('api.weatherapi.com', '/v1/forecast.json', parameters);
      Response response = await get(uri);
      Map<String, dynamic> tData = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return tWeather(
            location: tData['location']['name'],
            condition: tData['current']['condition']['text'],
            temperatureC: tData['current']['temp_c'],
            forecastHour: tData['forecast']['forecastday'][0]['hour']);
      } else {
        throw Exception('Unable to get Data from API');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class tWeather {
  final String location;
  final String condition;
  final double temperatureC;

  final dynamic forecastHour;

  tWeather(
      {this.location = '',
      this.condition = "Sunny",
      this.temperatureC = 0,
      this.forecastHour = ""});
}
