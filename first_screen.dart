import 'package:flutter/material.dart';
import 'package:register/main.dart';
import 'package:register/user_service.dart';
import 'package:register/login_service.dart';
import 'package:register/jwt.dart';

class PupilPage extends StatelessWidget {
  PupilPage(this.user, this.token);
  final User user;
  final String token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Журнал',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Електронний журнал'),
        ),
        body: Center(
          child: Text('You are a student'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                    'Меню',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                    ),
                  ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                //selected: ;
                leading: Icon(Icons.info),
                title: Text('Як користуватись?'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.book_online_rounded),
                title: Text('Мої предмети'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PupilPage(user, token))
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.mark_chat_read_rounded),
                title: Text('Отримати всі оцінки'),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app_rounded),
                title: Text('Вихід'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ]
          )
        )
      ),
    );
  }
}

class TeacherPage extends StatelessWidget {
  TeacherPage(this.user, this.token);
  final User user;
  final String token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Журнал',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Електронний журнал'),
        ),
        body: Center(
          child: Text('You are a teacher'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                    'Меню',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                    ),
                  ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                //selected: widget.selected == 'projects',
                leading: Icon(Icons.info),
                title: Text('Як користуватись?'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('Мої класи'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.mark_chat_read_rounded),
                title: Text('Заповнити оцінки'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Вихід'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),                        
            ]
          )
        )
      ),
    );
  }
}

// class ErrorPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Журнал',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Електронний журнал'),
//         ),
//         body: Center(
//           child: Text('Не вдалося увійти'),
//         ),
//       ),
//     );
//   }
// }