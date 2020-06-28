import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class Event {
  final String time;
  final String task;
  final String desc;
  final bool isFinish;

  Event(this.time, this.task, this.desc, this.isFinish);
}

final List<Event> _eventList = [
  new Event('08:00', '기상', 'Personal', false),
  new Event('09:00', '밥먹기!', 'Personal', false),
  new Event('10:00', '씻기 ', 'Personal', false),
  new Event('11:00', '학교오기', 'Personal', false),
  new Event('12:00', '놀기', 'Personal', false),
  new Event('13:00', '공부시작!', 'Work', false),
];

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    return ListView.builder(
      itemCount: _eventList.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: IconDecoration(
                  iconSize: iconSize,
                  lineWidth: 1,
                  firstData: index == 0 ?? true,
                  lastData: index == _eventList.length - 1 ?? true,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            color: Color(0x20000000),
                            blurRadius: 5),
                      ]),
                  child: Icon(
                    _eventList[index].isFinish
                        ? Icons.fiber_manual_record
                        : Icons.radio_button_unchecked,
                    size: 20.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              Container(
                width: 80.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(_eventList[index].time),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Container(
                    padding: EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x20000000),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_eventList[index].task),
                        SizedBox(height: 12.0),
                        Text(_eventList[index].desc),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class IconDecoration extends Decoration {
  final double iconSize;
  final double lineWidth;
  final bool firstData;
  final bool lastData;

  IconDecoration({
    @required double iconSize,
    @required final double lineWidth,
    @required final bool firstData,
    @required final bool lastData,
  })  : this.iconSize = iconSize,
        this.lineWidth = lineWidth,
        this.firstData = firstData,
        this.lastData = lastData;

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return IconLine(
        iconSize: iconSize,
        lineWidth: lineWidth,
        firstData: firstData,
        lastData: lastData);
  }
}

class IconLine extends BoxPainter {
  final double iconSize;
  final bool firstData;
  final bool lastData;

  final Paint paintLine;

  IconLine({
    @required double iconSize,
    @required final double lineWidth,
    @required final bool firstData,
    @required final bool lastData,
  })  : this.iconSize = iconSize,
        this.firstData = firstData,
        this.lastData = lastData,
        paintLine = Paint()
          ..color = Colors.red
          ..strokeCap = StrokeCap.round
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final leftOffset = Offset((iconSize / 2) + 24.0, offset.dy);
    final double iconSpace = iconSize / 1.5;

    final Offset top = configuration.size.topLeft(Offset(leftOffset.dx, 0.0));
    final Offset centerTop = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy - iconSpace));

    final Offset centerBottom = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy + iconSpace));
    final Offset end =
        configuration.size.bottomLeft(Offset(leftOffset.dx, leftOffset.dy * 2));

    if (!firstData) canvas.drawLine(top, centerTop, paintLine);
    if (!lastData) canvas.drawLine(centerBottom, end, paintLine);
  }
}
