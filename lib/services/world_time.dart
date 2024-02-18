import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name on the UI
  String time = ''; //the time in that location
  String flag; //url to an asset flag icon
  String url_var; //url for location api endpoint
  late bool isDaytime;

  WorldTime(
      {required this.location, required this.flag, required this.url_var});

  Future<void> getTime() async {
    try {
      //make a request
      Uri url = Uri.parse('http://worldtimeapi.org/api/timezone/$url_var');
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      //extracting the hour part from offset
      String offset_hour = offset.substring(1, 3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hour)));

      //set the time property
      time = DateFormat.jm().format(now);

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get the time';
    }
  }
}
