import 'package:flutter/material.dart';
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key, required this.fullName});
  final String fullName;
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/mainscreen", arguments: widget.fullName);
              },
              child: Container(
                alignment: Alignment.center,
                width: 500,
                height: 250,
                      decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text("ENCODE", style: TextStyle(fontSize: 25),),
                ),
            ),
              SizedBox(height: 20,),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/decode", arguments: widget.fullName);
            },
            child: Container(
              alignment: Alignment.center,
                width: 500,
                height: 250,
            decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text("DECODE", style: TextStyle(fontSize: 25),),
                ),
          )

          ],
        ),
      ),
    );
  }
}