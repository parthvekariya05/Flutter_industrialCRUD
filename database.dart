import "dart:convert";
import "package:http/http.dart" as http;
import "package:sqflite/sqflite.dart";
class MyDataBase{

  Future<Database> onInit() async {
    Database db=await openDatabase("demo.db",onCreate: (db, version) {
      db.execute("create table demo(id integer,name text,email text,gender text,job text)");
    },version: 1);
    return db;
  }

  Future<List> get() async {
    Database db=await onInit();
    List DatabaseList=await db.query("demo");
    var res =await http.get(Uri.parse("https://65e7b5c853d564627a8f2940.mockapi.io/demo"));
    List<dynamic> ApiData=await jsonDecode(res.body);
    if(DatabaseList.length==ApiData.length){
      return DatabaseList;
    }else{
      await db.delete("demo");
      for(var i=0;i<ApiData.length;i++){
        db.insert("demo", {"id":ApiData[i]["id"],"name":ApiData[i]["name"],
          "email":ApiData[i]["email"],"gender":ApiData[i]["gender"],"job":ApiData[i]["job"]});
      }
    }
    return DatabaseList;
  }

  Future<void> insert(map) async {
    Database db=await onInit();
    await http.post(Uri.parse("https://65e7b5c853d564627a8f2940.mockapi.io/demo"),body: map).then((value) async {
      await db.insert("demo",jsonDecode(value.body));
    });
  }

  Future<void> update(map,id) async {
    Database db=await onInit();
    await db.update("demo",map,where: "id = ?",whereArgs: [id]).then((value) {
      http.put(Uri.parse("https://65e7b5c853d564627a8f2940.mockapi.io/demo/$id"),body: map);
    },);
  }

  Future<void> delete(id) async {
    Database db=await onInit();
    await db.delete("demo",where: "id = ?",whereArgs: [id]).then((value) async {
      await http.delete(Uri.parse("https://65e7b5c853d564627a8f2940.mockapi.io/demo/$id"));
    });
  }
}