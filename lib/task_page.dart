import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(uri: 'http://192.168.0.8:5000/graphql');
    final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ));
    return GraphQLProvider(
      child: TaskList(),
      client: client,
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  String readTask = """
  query{
    allTasks{
      edges{
        node{
          task
          isFinish
        }
      }
    }
  }
  """;
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(documentNode: gql(readTask)),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.data == null) {
          return Text("No DATA");
        } else if (result.hasException) {
          return Text("error");
        }
        return ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: result.data['allTasks']['edges'].length,
          itemBuilder: (context, index) {
            return result.data['allTasks']['edges'][index]['node']['isFinish']
                ? _taskComplete(
                    result.data['allTasks']['edges'][index]['node']['task'])
                : _taskUncomplete(
                    result.data['allTasks']['edges'][index]['node']['task']);
          },
        );
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
