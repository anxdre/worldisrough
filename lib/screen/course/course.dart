import 'package:flutter/material.dart';

import 'coursedetail.dart';

class CoursePage extends StatelessWidget {
  final List<Map<String, dynamic>> _listOfCourse = [];

  CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    _addCourseList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course'),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                const Center(
                  child: CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/images/profile.jpg')),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Andre Setiawan A",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const Text("160420131"),
                const Text("Teknik Informatika"),
                const Text("Gasal 2023 - 2024"),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: (8 / 2),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < _listOfCourse.length; i++)
                          Card(
                              child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            child: Center(
                              child: ListTile(
                                title: Text(_listOfCourse[i]["title"]),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CourseDetail(
                                        title: _listOfCourse[i]["title"],
                                        kp: _listOfCourse[i]["kp"],
                                        day: _listOfCourse[i]["day"],
                                        room: _listOfCourse[i]["room"],
                                        totalTime: _listOfCourse[i]
                                            ["totalTime"])),
                              );
                            },
                          ))
                      ]),
                ),
              ],
            )
          ],
        ));
  }

  _addCourseList() {
    var listOfTitle = [
      "Emerging Technology",
      "Advanced Native Mobile Programming",
      "Full-Stack Programming",
      "Enterprise System Implementation",
      "Hybrid Mobile Programming",
      "Machine Learning"
    ];
    var listOfKp = ["-", "-", "E", "-", "C", "B"];
    var listOfDay = [
      "Senin - 07.00",
      "Senin - 13.00",
      "Selasa - TB 01.01A",
      "Selasa",
      "Rabu",
      "Rabu"
    ];
    var listOfRoom = [
      "TB 01.01A",
      "TG 03.02",
      "TG 03.02",
      "TC 04.01A",
      "TB 01.01B",
      "LA 02.06A"
    ];
    var listOfTotalTime = [
      "3 SKS",
      "3 SKS",
      "3 SKS",
      "3 SKS",
      "3 SKS",
      "3 SKS",
    ];

    for (int i = 0; i < listOfTitle.length; i++) {
      var data = <String, dynamic>{};
      data['title'] = listOfTitle[i];
      data['kp'] = listOfKp[i];
      data['day'] = listOfDay[i];
      data['room'] = listOfRoom[i];
      data['totalTime'] = listOfTotalTime[i];
      _listOfCourse.add(data);
    }
  }
}
