import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/sqlDb.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'CreateQuizScreen.dart';
import 'StartQuizScreen.dart';

Future<void> main() async {
if (!kIsWeb && (Platform.isMacOS  ||Platform.isWindows ||Platform.isLinux) ){
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

  WidgetsFlutterBinding.ensureInitialized();
  await SqlDb().initialDb();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      title: ' Quiz App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          textDirection: TextDirection.rtl,
          text: const TextSpan(
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            text: (" Quiz App "),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 25.0,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Alaa nijim'),
              accountEmail: Text("alaanijim20@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pink,
                child: Text(
                  'A',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const CreateQuizScreen();
                }));
              },
              child: const ListTile(
                leading: Icon(Icons.create),
                title: Text('Create Quiz'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return StartQuiz();
                }));
              },
              child: const ListTile(
                leading: Icon(Icons.question_mark),
                title: Text('Start Quiz'),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "photos/quiz.png",
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return StartQuiz();
                  }));
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 25.0),
                  child: Text(
                    "Let's Start!",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
