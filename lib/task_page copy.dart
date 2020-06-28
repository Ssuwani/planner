import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class Task {
  //생성자 생성
  final String task;
  final bool isFinish;
  const Task(this.task, this.isFinish);
}

//더미 리스트 생성
final List<Task> _taskList = [
  new Task('효진이랑 주말 약속 잡기', false),
  new Task('망고 똥치우기', false),
  new Task('마트가서 장보기', false),
  new Task('Flutter 공부하기', false),
  new Task('오메가3, 멀티비타민 챙겨먹기', true),
  new Task('스트레칭 하기', true),
];

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //ListView 위젯의 builder 생상자를 이용하여 스크롤 가능한 목록을 구현
      //.builder : 뷰의 크기를 자유자재로 동적으로 바꾸게 해줌
      padding: const EdgeInsets.all(0),
      itemCount: _taskList.length,
      //리스트뷰의 갯수를 제한하고 싶으면 itemCount 속성을 써준다. (이게 없으면 뷰가 무제한 생성됨)
      //예를 들면, itemCount: 5 : 5개만 표시된다.
      itemBuilder: (context, index) {
        //itemBuilder : 리스트뷰의 꼭 필요한 속성, 아이템 빌더는 안에 들어가는 아이템 모양을 정함.
        // context : 여기 코드가 실행될 때 이 앱의 현재상황,
        // index : ListView 의 인덱스 0부터 시작.
        return _taskList[index].isFinish
            ? _taskComplete(_taskList[index].task) //조건이 true일 때,
            : _taskUncomplete(_taskList[index].task); //조건이 false일 때,
      },
    );
  }

  Widget _taskUncomplete(String task) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 24.0),
      //요소의 left, bottom 만 패딩 적용
      child: Row(
        children: <Widget>[
          Icon(
            Icons.radio_button_unchecked,
            color: Theme.of(context).accentColor,
            size: 20.0,
          ),
          SizedBox(
            width: 28.0,
          ),
          Text(task),
        ],
      ),
    );
  }

  Widget _taskComplete(String task) {
    return Container(
      foregroundDecoration:
          BoxDecoration(color: Color(0x60FDFDFD)), //ARGB 형식의 색상 지정 (투명도 지정시)
      //BoxDecoration: Container를 꾸며준다.
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 24.0),
        //요소의 left, bottom 만 패딩 적용
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).accentColor,
              size: 20.0,
            ),
            SizedBox(
              width: 28.0,
            ),
            Text(task),
          ],
        ),
      ),
    );
  }
}