import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  late TextEditingController usernamecontroller;
  late TextEditingController passwordcontroller;
  bool isButtonActive =true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernamecontroller = new TextEditingController();
    passwordcontroller = new TextEditingController();
    final usernameRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    usernamecontroller.addListener((){
      final isButtonActive=(usernameRegex.hasMatch(usernamecontroller.text));
      setState(() {
        this.isButtonActive=isButtonActive;
      });
    });
    passwordcontroller.addListener((){
      setState(() {
        this.isButtonActive=false;
      });
      final passRegex=RegExp(r'^(?=.*[A-Z].*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&(),.?":{}|<>])');
      final isValidPassword = passRegex.hasMatch(passwordcontroller.text) && passwordcontroller.text.length >= 8 && passwordcontroller.text.length <= 50;
      if(isValidPassword){
        setState(() {
          this.isButtonActive=isValidPassword;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Center(child: Text("Registration",style: TextStyle(fontSize: 55,color: Colors.cyan,fontWeight: FontWeight.bold),)),
              SizedBox(height: 15,),
              Text("UserName: ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              TextField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: "Username as example@gmail.com",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5,),
              Text("Password: ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
              TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              Text("-Password must be atleast 8 characters.\n-Password must contain atleast two capital letters."
                  "\n-Password must contain atleast one small letter.\n-Password must contain one special character, But don't use *.",
                style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan,),
                  onPressed: isButtonActive?() async{
                    setState(() {
                      isButtonActive=false;
                    });
                    showDialog(
                      context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Registration"),
                          content: Text("Registration Successful"),
                          actions: [
                            ElevatedButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text("Ok"))
                          ],
                        );
                    });
                    final username=usernamecontroller.text;
                    final pass=passwordcontroller.text;
                    try {
                      await FlutterLogs.logToFile(
                        logFileName: "KaamConnect Assignment",
                        overwrite: false,
                        logMessage: "\nUserName: $username Password: $pass",
                      );
                    }catch(e){
                      print(e);
                    }
                  }:null,
                  child: Text("Submit",style: TextStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
