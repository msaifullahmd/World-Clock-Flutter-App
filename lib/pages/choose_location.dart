import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url_var: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url_var: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(url_var: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(
        url_var: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url_var: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(
        url_var: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(
        url_var: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(
        url_var: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(
            'Choose a location',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        updateTime(index);
                      },
                      title: Text(locations[index].location),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/${locations[index].flag}'),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
