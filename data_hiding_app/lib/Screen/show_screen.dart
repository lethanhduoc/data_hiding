import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class ShowScreen extends StatefulWidget {
  const ShowScreen({super.key, required this.fullName});
  final String fullName;

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  String content = '';
  String image = "";
  String created_on = "";
  String display_name = "";
  int length = 0;
  int status = 1;
  bool isActive = false;
  String messages = "";


  @override
  Widget build(BuildContext context) {
    String username = widget.fullName;
    Future fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.136:8000/api/get-article?username=$username'));

    if (response.statusCode == 200) {
      // Đã nhận được dữ liệu thành công
      Map<String, dynamic> data = json.decode(response.body);
      
      setState(() {
        length = data.length;
        messages = data['message'];
        status = data['result'];
        content = data['data'][0]['content'].toString();
        image = data['data'][0]['image'];
        created_on = data['data'][0]['created_on'];
        display_name = data['data'][0]['display_name'];
      });
    } else {
      // Xử lý lỗi
      print('Error: ${response.statusCode}');
    }
  }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:Text("Data Hiding", style: GoogleFonts.sarabun(color:Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                      backgroundColor: Color.fromARGB(255, 9, 32, 51),
                      actions: [
                        IconButton(onPressed: (){
                    //       Provider.of<UserData>(context, listen: false)
                    // .setUserData('', image, contentController.text);
                    // _uploadData(context);
                        }, icon: IconButton( onPressed: () {widget.fullName=="admin"? Navigator.pushNamed(context, "/admin",arguments: widget.fullName):Navigator.pushNamed(context, "/mainscreen",
                                  arguments: widget.fullName
                                  );}, icon:Icon(Icons.add)), iconSize: 35,)
                      ]),
        body: 
           SingleChildScrollView(
             child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    fetchData();
                    setState(() {
                      isActive = true;
                    });
                  },
                  child: Text('Fetch Data'),
                ),
              //   isActive?
              // ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: 4,
              //         itemBuilder: (context, index){
              //  SizedBox(height: 20);
              //   Text('Content: $content', style: TextStyle(color:Colors.black),);
              //   SizedBox(height: 20,);
              //   Text('Name: $display_name', style: TextStyle(color:Colors.black),);
              //   SizedBox(height: 20,);
              //   Text('Create On: $created_on', style: TextStyle(color:Colors.black),);
              //   SizedBox(height: 20,);
              //   //Text('Image: $image', style: TextStyle(color:Colors.black),),
              //   isActive?Image.network(image, width: 200,height: 200,):Container();
              //   //result = 0, =1
              //   return ListTile(
              //     title: Text(content),
              //     subtitle: Text('Created on: $created_on\nDisplay Name: $display_name'),
              //     leading: Image.network(image), 
              //   );
              //         },
              //   ):Container()
                
                SizedBox(height: 20),
                Text('Content: $content', style: TextStyle(color:Colors.black),),
                SizedBox(height: 20,),
                Text('Name: $display_name', style: TextStyle(color:Colors.black),),
                SizedBox(height: 20,),
                Text('Create On: $created_on', style: TextStyle(color:Colors.black),),
                SizedBox(height: 20,),
                //Text('Image: $image', style: TextStyle(color:Colors.black),),
                status==1?Image.network(image, width: 200,height: 200,):Container(),
                //result = 0, =1
                if(status==0)
                  Text("Chưa có bài báo nào", style:TextStyle(fontSize: 25))
                
              ],
                     ),
           ),
        
      ),
    );
  }
}