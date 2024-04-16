import 'package:bothcrud/adduser.dart';
import 'package:bothcrud/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MyDataBase().onInit();
    List User = [];
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Home Page",
        style: TextStyle(color: Colors.red),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEdit(),
              )).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: MyDataBase().get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User.clear();
            User.addAll(snapshot.data!);

            return ListView.builder(
              itemCount: User.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.cyanAccent)),
                    title: Column(
                      children: [
                        Text(User[index]["name"]),
                        Text(User[index]["email"]),
                        Text(User[index]["gender"]),
                      ],
                    ),
                    leading: GestureDetector(
                        onTap: () {
                          MyDataBase().delete(User[index]["id"]).then((value) {
                            setState(() {});
                          });
                        },
                        child: Icon(Icons.delete, color: Colors.red)),
                    trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddEdit(userObject: {...User[index]}),
                              )).then((value) {
                            setState(() {});
                          });
                        },
                        child: Icon(Icons.edit, color: Colors.blue)),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text("Data is Loading"),
          );
        },
      ),
    );
  }
}
