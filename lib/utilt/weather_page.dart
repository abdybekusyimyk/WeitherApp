class WeatherappUtilts {
  static String calculateWeather(double kelvin) {
    return (kelvin - 273.15).toStringAsFixed(0);
  }

  static String getWeatherIcon(double kelvin) {
    if (kelvin < 200) {
      return ' 🌧';
    } else if (kelvin < 400) {
      return '☀️';
    } else if (kelvin < 600) {
      return '☔️';
    } else if (kelvin < 700) {
      return '☃️';
    } else if (kelvin < 800) {
      return '🌫';
    } else if (kelvin == 800) {
      return '☁️';
    } else if (kelvin <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getDescription(int celcius) {
    if (celcius > 25) {
      return 'It\'s 🍦 time';
    } else if (celcius < 20) {
      return 'Time for shorts and 👕';
    } else if (celcius < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 👕 just in case';
    }
  }
}
