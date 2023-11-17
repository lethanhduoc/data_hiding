import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class ShowScreenResult extends StatefulWidget {
  const ShowScreenResult({super.key, required this.fullName});
  final String fullName;

  @override
  State<ShowScreenResult> createState() => _ShowScreenResultState();
}

class _ShowScreenResultState extends State<ShowScreenResult> {
  String image = "";
  String logo = "";



  @override
  Widget build(BuildContext context) {
    String username = widget.fullName;
    Future fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.136:8000/api/get-article?username=$username'));

    if (response.statusCode == 200) {
      // Đã nhận được dữ liệu thành công
      Map<String, dynamic> data = json.decode(response.body);
      
      setState(() {
        image = data['data'][0]['image_url'];
        logo = data['data'][0]['logo_url'];

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
                      ),
        body: 
           SingleChildScrollView(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    fetchData();
                    setState(() {
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
                Image.network(logo, width: 200,height: 200,),
                SizedBox(height: 20),
                //Text('Image: $image', style: TextStyle(color:Colors.black),),
                Image.network(image, width: 200,height: 200,)
                //result = 0, =1

                
              ],
                     ),
           ),
        
      ),
    );
  }
}