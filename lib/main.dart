import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const ResourceViewBuilder());

class ResourceViewBuilder extends StatefulWidget {
  const ResourceViewBuilder({Key? key}) : super(key: key);
  @override
  ResourceViewBuilderState createState() => ResourceViewBuilderState();
}

class ResourceViewBuilderState extends State<ResourceViewBuilder> {
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.timelineDay,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek,
    CalendarView.timelineMonth,
  ];
  final List<String> _subjectCollection = <String>[];
  final List<Color> _colorCollection = <Color>[];
  List<Appointment> _shiftCollection = <Appointment>[];
  final List<CalendarResource> _employeeCollection = <CalendarResource>[];
  final List<String> _nameCollection = <String>[];
  final List<String> _userImages=<String>[];
  _DataSource? _events;

  @override
  void initState() {
    _addResourceDetails();
    _addResources();
    _addAppointmentDetails();
    _addAppointments();
    _events = _DataSource(_shiftCollection, _employeeCollection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.timelineWeek,
            showDatePickerButton: true,
            allowedViews: _allowedViews,
            dataSource: _events,
            resourceViewHeaderBuilder: resourceBuilder,
          ),
        ),
      ),
    );
  }

  void _addResourceDetails() {
    _nameCollection.add('John');
    _nameCollection.add('Bryan');
    _nameCollection.add('Robert');
    _nameCollection.add('Kenny');
    _nameCollection.add('Tia');
    _nameCollection.add('Theresa');
    _nameCollection.add('Edith');
    _nameCollection.add('Brooklyn');
    _nameCollection.add('James William');
    _nameCollection.add('Sophia');
    _nameCollection.add('Elena');
    _nameCollection.add('Stephen');
    _nameCollection.add('Zoey Addison');
    _nameCollection.add('Daniel');
    _nameCollection.add('Emilia');
    _nameCollection.add('Kinsley Elena');
    _nameCollection.add('Daniel');
    _nameCollection.add('William');
    _nameCollection.add('Addison');
    _nameCollection.add('Ruby');

    _userImages.add('images/People_Circle5.png');
    _userImages.add('images/People_Circle8.png');
    _userImages.add('images/People_Circle18.png');
    _userImages.add('images/People_Circle23.png');
    _userImages.add('images/People_Circle25.png');
    _userImages.add('images/People_Circle20.png');
    _userImages.add('images/People_Circle13.png');
    _userImages.add('images/People_Circle11.png');
    _userImages.add('images/People_Circle27.png');
    _userImages.add('images/People_Circle26.png');
    _userImages.add('images/People_Circle24.png');
    _userImages.add('images/People_Circle15.png');
  }

  void _addResources() {
    Random random = Random();
    for (int i = 0; i < _nameCollection.length; i++) {
      _employeeCollection.add(CalendarResource(
          displayName: _nameCollection[i],
          id: '000$i',
          color: Color.fromRGBO(
              random.nextInt(255), random.nextInt(255), random.nextInt(255), 1),
          image:
          i < _userImages.length ? ExactAssetImage(_userImages[i]) : null
      ));
    }
  }

  void _addAppointmentDetails() {
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');
    _subjectCollection.add('Project Plan');
    _subjectCollection.add('Consulting');
    _subjectCollection.add('Support');
    _subjectCollection.add('Development Meeting');
    _subjectCollection.add('Scrum');
    _subjectCollection.add('Project Completion');
    _subjectCollection.add('Release updates');
    _subjectCollection.add('Performance Check');

    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
  }

  void _addAppointments() {
    _shiftCollection = <Appointment>[];
    final Random random = Random();
    for (int i = 0; i < _employeeCollection.length; i++) {
      final List<String> _employeeIds = <String>[
        _employeeCollection[i].id.toString()
      ];
      if (i == _employeeCollection.length - 1) {
        int index = random.nextInt(5);
        index = index == i ? index + 1 : index;
        _employeeIds.add(_employeeCollection[index].id.toString());
      }

      for (int k = 0; k < 365; k++) {
        if (_employeeIds.length > 1 && k % 2 == 0) {
          continue;
        }
        for (int j = 0; j < 2; j++) {
          final DateTime date = DateTime.now().add(Duration(days: k + j));
          int startHour = 9 + random.nextInt(6);
          startHour =
          startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime _shiftStartTime =
          DateTime(date.year, date.month, date.day, startHour, 0, 0);
          _shiftCollection.add(Appointment(
              startTime: _shiftStartTime,
              endTime: _shiftStartTime.add(const Duration(hours: 1)),
              subject: _subjectCollection[random.nextInt(8)],
              color: _colorCollection[random.nextInt(8)],
              startTimeZone: '',
              endTimeZone: '',
              resourceIds: _employeeIds));
        }
      }
    }
  }

  Widget resourceBuilder(
      BuildContext context, ResourceViewHeaderDetails details) {
    if (details.resource.image != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(backgroundImage:details.resource.image,backgroundColor: details.resource.color),
          Center(child: Text(details.resource.displayName,textAlign: TextAlign.center,)),
        ],
      );
    }
    else {
      return Container(
        color: details.resource.color,
        child: Text(details.resource.displayName),
      );
    }
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}