// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => UserData()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(),
//     );
//   }
// }

// class LoginPage extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: 'Enter username'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Lưu username vào Provider
//                 Provider.of<UserData>(context, listen: false)
//                     .setUserData(usernameController.text, null);
//                 // Chuyển đến màn hình chính
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MainPage()),
//                 );
//               },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MainPage extends StatelessWidget {
//   final TextEditingController imageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Main Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Mở thư viện để chọn ảnh
//                 _pickImage(context);
//               },
//               child: Text('Choose Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Gửi dữ liệu lên API
//                 _uploadData(context);
//               },
//               child: Text('Upload Data to API'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Hàm để chọn ảnh từ thư viện
//   Future<void> _pickImage(BuildContext context) async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Lưu đối tượng File vào Provider
//       Provider.of<UserData>(context, listen: false)
//           .setUserData('', File(pickedFile.path));
//     }
//   }

//   // Hàm để gửi dữ liệu lên API
//   void _uploadData(BuildContext context) async {
//     final userData = Provider.of<UserData>(context, listen: false);

//     // Kiểm tra xem có hình ảnh không
//     if (userData.image != null) {
//       // Gửi dữ liệu lên API
//       final response = await _uploadImage(userData.image!);
      
//       // Xử lý phản hồi từ API
//       if (response.statusCode == 200) {
//         // Xử lý dữ liệu trả về nếu cần
//         print('Success: ${response.body}');
//       } else {
//         // Xử lý lỗi nếu có
//         print('Error: ${response.statusCode}');
//       }
//     }
//   }

//   // Hàm để gửi ảnh lên API
//   Future<http.Response> _uploadImage(File image) async {
//     final url = Uri.parse('http://127.0.0.1:8000/api/post-article');
//     final request = http.MultipartRequest('POST', url)
//       ..files.add(
//         await http.MultipartFile.fromPath(
//           'images',
//           image.path,
//           filename: 'image.jpg',
//           contentType: MediaType('image', 'jpeg'),
//         ),
//       );

//     return await http.Response.fromStream(await request.send());
//   }
// }
