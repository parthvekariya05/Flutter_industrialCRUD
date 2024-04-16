import "package:bothcrud/database.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class AddEdit extends StatefulWidget {
  Map? userObject={};
  AddEdit({super.key,this.userObject});

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name=TextEditingController();
    TextEditingController email=TextEditingController();
    TextEditingController job=TextEditingController();
    TextEditingController gender=TextEditingController();
    name.text=widget.userObject?["name"]??"";
    email.text=widget.userObject?["email"]??"";
    job.text=widget.userObject?["job"]??"";
    gender.text=widget.userObject?["gender"]??"";
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          TextFormField(
              controller: name,
              decoration: InputDecoration(
                  hintText: "enter your name",
                  labelText: "Name",),
          ),
          TextFormField(
              controller: email,decoration: InputDecoration(hintText: "enter your email",labelText: "Email")),
          TextFormField(
              controller: job,decoration: InputDecoration(hintText: "enter your job",labelText: "Job")),
          TextFormField(
              controller: gender,decoration: InputDecoration(hintText: "enter your gender M OR F",labelText: "Gender")),
          ElevatedButton(onPressed: () {
            widget.userObject!=null?
            MyDataBase().update({"name":name.text,"email":email.text,"job":job.text,"gender":gender.text}, widget.userObject?["id"]).then((value) {
              Navigator.pop(context);
            }):
            MyDataBase().insert({"name":name.text,"email":email.text,"job":job.text,"gender":gender.text}).then((value) {
              Navigator.pop(context);
            })
            ;
          }, child: Text(widget.userObject==null?"Add":"edit")),
        ],
      ),
    );
  }
}