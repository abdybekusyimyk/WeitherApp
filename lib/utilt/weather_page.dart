class WeatherappUtilts {
  static String calculateWeather(double kelvin) {
    return (kelvin - 273.15).toStringAsFixed(0);
  }

  static String getWeatherIcon(double kelvin) {
    if (kelvin < 200) {
      return ' ๐ง';
    } else if (kelvin < 400) {
      return 'โ๏ธ';
    } else if (kelvin < 600) {
      return 'โ๏ธ';
    } else if (kelvin < 700) {
      return 'โ๏ธ';
    } else if (kelvin < 800) {
      return '๐ซ';
    } else if (kelvin == 800) {
      return 'โ๏ธ';
    } else if (kelvin <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  static String getDescription(int celcius) {
    if (celcius > 25) {
      return 'It\'s ๐ฆ time';
    } else if (celcius < 20) {
      return 'Time for shorts and ๐';
    } else if (celcius < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐ just in case';
    }
  }
}
