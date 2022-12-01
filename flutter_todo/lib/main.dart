import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'addTodo.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes:  {
        '/' : (context) => DatabaseApp(database),
        '/add' : (context) => AddTodoApp(database),
      },
    );
  }
  Future<Database> initDatabase() async {
    return openDatabase( // 데이터 베이스 열기
    join(await getDatabasePath(), 'todo_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT, content TEXT, active BOOL)",
      );
    },
    version: 1,
    );
  }
  
  getDatabasePath() {}
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  const DatabaseApp(this.db, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Todo>> todoList;

 @override
 void initState() {
    super.initState();
    todoList = getTodos(); // 로딩과 동시에 목록 읽기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example'),
      ),
       body: Center(
         child: FutureBuilder(
          // ignore : missing return
             builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                 case ConnectionState.none:
                   return const CircularProgressIndicator();
                 case ConnectionState.waiting:
                   return const CircularProgressIndicator();
                 case ConnectionState.active:
                   return const CircularProgressIndicator();
                 case ConnectionState.done:
                   if (snapshot.hasData) {
                     return ListView.builder(
                       itemBuilder: (context, index) {
                         Todo todo = snapshot.data[index];
                          return ListTile(
                           title: Text(
                           todo.title,
                           style: const TextStyle(fontSize: 20),
                        ),
                       subtitle: Column(
                         children: <Widget>[
                           Text(todo.content),
                           Text('체크 : ${todo.active.toString()}'),
                           Container(
                             height: 1,
                             color: Colors.blue,
                           )
                         ],
                       ),
                       onTap: () async {
                         TextEditingController controller =
                           TextEditingController(text: todo.content);

                         Todo result = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                             return AlertDialog(
                                 content: TextField(
                                   controller: controller,
                                   keyboardType: TextInputType.text, // 텍스트 입력 키보드
                                    ),
                                  actions: <Widget>[
                                   TextButton(
                                       onPressed: () {
                                       // ignore: unrelated_type_equality_checks
                                       todo.active == true // 할일 상태
                                              ? todo.active = false
                                              : todo.active = true;
                                          todo.content = controller.value.text;
                                       Navigator.of(context).pop(todo);
                                       },
                                       child: const Text('예')),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                       },
                                       child: const Text('아니요')),
                                   ],
                              );
                           });
                           if (result != null) {
                           _updateTodo(result);
                         }
                       },
                     );
                   },

                     itemCount: (snapshot.data as List<Todo>).length,
                  );
                   } else {
                   return const Text('No data'); // 데이터 없는 경우
                   }
                 }
             return const CircularProgressIndicator(); // 로딩 화면 대기
           },
           future: todoList,
         ),
       ),


        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (todo != null) {
              _insertTodo(todo as Todo);
            } 
            final todo = await Navigator.of(context).pushNamed('/add');
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
  void _insertTodo (Todo todo) async {
    final Database database = await widget.db;
    await database.insert ('todos', todo.toMap(), // 데이터 삽입 구문
    conflictAlgorithm: ConfilctAlgorithm.replace);
    setState(() {
      todoList = getTodos(); // 출력
    });
  }

  void _updateTodo(Todo todo) async {
     final Database database = await widget.db;
      await database.update( // 데이터 업데이트 구문
        'todos',
        todo.toMap(),
        where: 'id = ? ', // id로 업데이트 할 데이터를 식별
        whereArgs: [todo.id],
     );
      setState(() {
       todoList = getTodos();
     });
  }

  void _deleteTodo(Todo todo) aysnc {
    final Database database = await wiget.db;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]); // 데이터 삭제 구문
    setState(() {
      todoList = getTodos();
    });
  }

   Future<List<Todo>> getTodos() async {
 final Database database = await widget.db;
 final List<Map<String, dynamic>> maps = await database.query('todos');
    // 맵 목록에서 리스트 생성
    return List.generate(maps.length, (i) {
      bool active = maps[i]['active'] == 1 ? true : false;
      return Todo(
        title: maps[i]['title'].toString(),
        content: maps[i]['content'].toString(),
        active: active,
        id: maps[i]['id']);
      });
    }
 }  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Future<List<Todo>>>('todoList', todoList));
  }
