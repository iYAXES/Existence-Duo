import 'package:flutter/material.dart';
import 'package:world_and_weather_app/weather/weatherService.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  WeatherServices weatherServices = WeatherServices();
  List getHour = [];
  List getDay = [];

  List<LocationName> locations = [
    LocationName(name: 'Akure'),
    LocationName(name: 'Abuja'),
    LocationName(name: ' Abu Dhabi  '),
    LocationName(name: ' Amsterdam  '),
    LocationName(name: ' Ankara  '),
    LocationName(name: ' Athens  '),
    LocationName(name: ' Atlanta  '),
    LocationName(name: ' Auckland  '),
    LocationName(name: ' Baghdad  '),
    LocationName(name: 'Baltimore'),
    LocationName(name: ' Bangkok  '),
    LocationName(name: ' Barcelona  '),
    LocationName(name: ' Beijing  '),
    LocationName(name: ' Beirut  '),
    LocationName(name: ' Berlin  '),
    LocationName(name: ' Bogota  '),
    LocationName(name: ' Boston  '),
    LocationName(name: ' Brasilia  '),
    LocationName(name: ' Brussels  '),
    LocationName(name: ' Buenos Aires  '),
    LocationName(name: ' Cairo  '),
    LocationName(name: ' Cape Town  '),
    LocationName(name: ' Caracas  '),
    LocationName(name: ' Chicago  '),
    LocationName(name: ' Copenhagen  '),
    LocationName(name: ' Dallas  '),
    LocationName(name: ' Damascus  '),
    LocationName(name: ' Casablanca  '),
    LocationName(name: ' Delhi  '),
    LocationName(name: ' Dhaka  '),
    LocationName(name: ' Dubai  '),
    LocationName(name: ' Dublin  '),
    LocationName(name: ' Edinburgh  '),
    LocationName(name: ' Frankfurt  '),
    LocationName(name: ' Geneva  '),
    LocationName(name: ' Guangzhou  '),
    LocationName(name: ' Havana  '),
    LocationName(name: ' Helsinki  '),
    LocationName(name: ' Hong Kong  '),
    LocationName(name: ' Houston  '),
    LocationName(name: ' Istanbul  '),
    LocationName(name: ' Jakarta  '),
    LocationName(name: ' Johannesburg  '),
    LocationName(name: ' Karachi  '),
    LocationName(name: ' Kathmandu  '),
    LocationName(name: ' Khartoum  '),
    LocationName(name: ' Kinshasa  '),
    LocationName(name: ' Kuala Lumpur  '),
    LocationName(name: ' Lagos  '),
    LocationName(name: ' Lima  '),
    LocationName(name: ' Lisbon  '),
    LocationName(name: ' London  '),
    LocationName(name: ' Los Angeles  '),
    LocationName(name: ' Madrid  '),
    LocationName(name: ' Manila  '),
    LocationName(name: ' Mexico City  '),
    LocationName(name: ' Miami  '),
    LocationName(name: ' Milan  '),
    LocationName(name: ' Montreal  '),
    LocationName(name: ' Moscow  '),
    LocationName(name: ' Mumbai  '),
    LocationName(name: ' Nairobi  '),
    LocationName(name: ' New Delhi  '),
    LocationName(name: ' New York  '),
    LocationName(name: ' Osaka  '),
    LocationName(name: ' Oslo  '),
    LocationName(name: ' Paris  '),
    LocationName(name: ' Perth  '),
    LocationName(name: ' Prague  '),
    LocationName(name: ' Quito  '),
    LocationName(name: ' Riyadh  '),
    LocationName(name: ' Rome  '),
    LocationName(name: ' San Francisco  '),
    LocationName(name: ' Santiago  '),
    LocationName(name: ' Sao Paulo  '),
    LocationName(name: ' Seoul  '),
    LocationName(name: ' Shanghai  '),
    LocationName(name: ' Singapore  '),
    LocationName(name: ' Stockholm  '),
    LocationName(name: ' Sydney  '),
    LocationName(name: ' Taipei  '),
    LocationName(name: ' Tehran  '),
    LocationName(name: ' Tel Aviv  '),
    LocationName(name: ' Tokyo  '),
    LocationName(name: ' Toronto  '),
    LocationName(name: ' Vancouver  '),
    LocationName(name: ' Vienna  '),
    LocationName(name: ' Warsaw  '),
    LocationName(name: ' Washington, D.C.  '),
    LocationName(name: ' Wellington  '),
    LocationName(name: ' Yangon  '),
  ];

  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  String? error;

  void updateWeather(String locationName) async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      Weather updateWeda = await weatherServices.getWeatherData(locationName);

      getHour = updateWeda.forecasthour;
      getDay = updateWeda.forecastday;

      Navigator.pop(context, {
        'location': updateWeda.location,
        'condition': updateWeda.conditon,
        'tempC': updateWeda.temperatureC,
        'heatlevel': updateWeda.heatlevel,
        'cloudlevel': updateWeda.cloudlevel,
        'getHour': getHour,
        'getDay': getDay,
      });
    } catch (e) {
      setState(() {
        error = 'Location not found or network error.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<LocationName> get filteredLocations {
    String query = _controller.text.toLowerCase();
    return locations
        .where((loc) => loc.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: const Text(
          'Select or Enter City',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  onSubmitted: updateWeather,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  enableInteractiveSelection: false,
                  style: const TextStyle(fontFamily: 'Montserrat'),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    hintText: 'Enter a city',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (_controller.text.trim().isNotEmpty) {
                          updateWeather(_controller.text.trim());
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                if (error != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredLocations.length,
                    itemBuilder: (context, index) {
                      var location = filteredLocations[index];
                      return ListTile(
                        title: Text(
                          location.name,
                          style: const TextStyle(fontFamily: 'Montserrat bold'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16),
                        onTap: () => updateWeather(location.name),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 🌀 Overlay loader
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
