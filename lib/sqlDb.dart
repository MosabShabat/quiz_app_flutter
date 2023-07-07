import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {


    static const String DB_NAME = 'quiz.db';
  static const int DB_VERSION = 1;

  static const String TABLE_QUESTIONS = 'questions';
  static const String COL_QUESTION_ID = 'id';
  static const String COL_QUESTION_TEXT = 'text';
  static const String COL_ANSWER_OPTIONS1 = 'options1';
  static const String COL_ANSWER_OPTIONS2 = 'options2';
  static const String COL_ANSWER_OPTIONS3 = 'options3';
  static const String COL_ANSWER_OPTIONS4 = 'options4';
  static const String COL_CORRECT_ANSWER = 'correct_answer';
  
  static Database? _db;

  Future<Database?> get db async {
    // ? => accept null //use get db in function (select , insert , delete )
    if (_db == null) {
      // check if DB initialized
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath(); // default path
    String path = join(databasePath,
        'Quiz.db'); //pass path and Name of DB => databasePath/Quiz.db
    Database myDB = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade); // create BD //
    return myDB;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("on Upgrade >>>>>>>>>");
  }

  _onCreate(Database db, int version) async {
    // create Table // call the function once when construct DB

    await db.execute('CREATE TABLE AddQuestions ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'Question TEXT NOT NULL,'
        'FirstAnswer TEXT NOT NULL,'
        'SecondAnswer TEXT NOT NULL,'
        'ThirdAnswer TEXT NOT NULL,'
        'FourthAnswer TEXT NOT NULL,'
        'CorrectAnswer TEXT NOT NULL'
        ')');
  }

  readData(String sql) async {
    //select

    Database? myDB = await db;
    List<Map> response = await myDB!
        .rawQuery(sql); // why but ! => can not use method by value accept null
    return response;
  }

  insertData(String sql) async {
    //insert

    Database? myDB = await db;
    int response = await myDB!.rawInsert(sql);
    // بترجع قيمة row الي تم اضافتو // return 0 if fail
    return response;
    //  print("insert successful!>>>>>>>>>>>>>>>>>>>>>>>>");
  }

  updateData(String sql) async {
    //update

    Database? myDB = await db;
    int response = await myDB!
        .rawUpdate(sql); // why but ! => can not use method by value accept null
    return response;
  }

  deleteData(String sql) async {
    //select
    Database? myDB = await db;
    int response = await myDB!
        .rawDelete(sql); // why but ! => can not use method by value accept null
    return response;
  }
  deleteResult(int quizId , int score , int totalQuestions) async{
    String sql = 'INSERT INTO Results(QuizId,Score,TotalQuestions) VALUES ($quizId ,$score,$totalQuestions) ';
    int result =await insertData(sql);
    print('Result inserted : $result');
  }
Future<List<Map<String,dynamic>>> getResults() async{
String sql = 'SELECT * FROM Results';
List<Map<String,dynamic>> results = await readData(sql);
return results;
}
Future<int> getTotalScore() async{
String sql = 'SELECT SUM (Score) AS TotalScore FROM Results';
List<Map<String,dynamic>> results = await readData(sql);
int totalScore = results.first['TotalScore'] ?? 0;
return totalScore;
}
}
