import 'package:data_hiding_app/image_picker.dart';
import 'package:data_hiding_app/user_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.fullName});
  final String fullName;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File? image;
  File? video;
  VideoPlayerController? _videoController;
  final TextEditingController contentController = TextEditingController();

  pickImage(ImageSource source){
    AppImagePicker(source: source).pick(onpick: (File? image){
      setState(() {
        this.image = image;
        Provider.of<UserData>(context, listen: false)
          .setUserData('', File(image!.path), '');
      });
    });
  }

void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
        "images/Download.mp4")
      ..initialize().then((_) {
        setState(() {
          _videoController!.play();
        });
      });
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        video = file;
        _videoController = VideoPlayerController.file(video!)
          ..initialize().then((_) {
            setState(() {
              _videoController!.play();
            });
          });
      });
    }
  }

  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:Text("Data Hiding", style: GoogleFonts.sarabun(color:Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                      backgroundColor: Color.fromARGB(255, 9, 32, 51),
                      actions: [
                        IconButton(onPressed: (){
                          _showAlertDialog(context);
                    //       Provider.of<UserData>(context, listen: false)
                    // .setUserData(widget.fullName, image, contentController.text);
                    _uploadData(widget.fullName, contentController.text, image!.path);
                        }, icon: Icon(Icons.check), iconSize: 35,)
                      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: const BoxDecoration(
              //color: Colors.grey
              image:DecorationImage(image: AssetImage("images/background2.jpeg"), fit: BoxFit.fill)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text("Welcome! Have a nice day", style: GoogleFonts.sarabun(fontWeight: FontWeight.bold, 
                // fontSize: 30, color: Colors.white)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text("Nhập văn bản", style:GoogleFonts.sarabun(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
                    Padding(
                                    padding: const EdgeInsets.only(top:10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      //padding: EdgeInsets.only(right: 20),
                                      width:
                                          screenSize.width/1.3,
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextFormField(
                                          controller: contentController,
                                          // onChanged: (value) =>
                                          //     {widget.fullName(value)},
                                          cursorColor: const Color.fromARGB(
                                              255, 35, 3, 103),
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 35, 3, 103),
                                          ),
                                          decoration: InputDecoration(
                                              hintText: "Nhập văn bản",
                                              hintStyle: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 14),
                                              labelStyle: const TextStyle(
                                                  color: Colors.black),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:30),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Tải lên ảnh", style:GoogleFonts.sarabun(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
                    SizedBox(height:10),
                    ElevatedButton(
                      style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(200, 50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 43, 191, 232)),
                                  ),
                      onPressed: (){pickImage(ImageSource.gallery);}, 
                                   child: SizedBox(
                                    width: 100,
                                    height: 50,
                                     child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                        Icon(Icons.file_upload),
                                        SizedBox(width: 5,),
                                         Text("Tải ảnh", style: GoogleFonts.sarabun(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                       ],
                                     ),
                                   )),
                                   SizedBox(height: 10,),
                    if(image != null)
                    SizedBox(
                      width:screenSize.width,
                      height:200,
                      child: Image.file(image!)),
                  ],
                ),
                Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Tải lên video", style:GoogleFonts.sarabun(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
                    SizedBox(height:10),
              
              ElevatedButton(
                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(200, 50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 43, 191, 232)),
                                  ),
                onPressed: _pickVideo,
                child: Text('Chọn video',style: GoogleFonts.sarabun(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              SizedBox(height: 10,),
              video != null
                  ? SizedBox(
                    width: screenSize.width/1.2,
                    height: 230,
                    child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                  )
                  : Text('Chưa có video'),
            ],
                  ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _uploadData(String username, String content, String imagepath) async {
    // final userData = Provider.of<UserData>(context, listen: false);
    final url = Uri.parse('http://192.168.1.136:8000/api/post-article');
    final request = http.MultipartRequest('POST', url)
      ..fields['username'] = username
      ..fields['content'] = content
      ..files.add(
        await http.MultipartFile.fromPath(
          'images',
          imagepath,
          filename: 'image.jpg',
          //contentType: MediaType('image', 'jpeg'),
        ),
      );
      

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        // Xử lý dữ liệu trả về nếu cần
        print('Success: ${await response.stream.bytesToString()}');
      } else {
        // Xử lý lỗi nếu có
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading data: $error');
    }
  }
}
void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Thành công', style: TextStyle(fontSize: 24),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

