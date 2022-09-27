// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: FingerprintApp(),
//   ));
// }

// class FingerprintApp extends StatefulWidget {
//   const FingerprintApp({super.key});

//   @override
//   State<FingerprintApp> createState() => _FingerprintAppState();
// }

// class _FingerprintAppState extends State<FingerprintApp> {
// //*Bây giờ chúng ta sẽ tạo chính để cho phép chúng ta sử dụng
// //*Cảm biến vân tay và xác thực
// //*Nhưng trước tiên, chúng ta cần thêm sự phụ thuộc local_auth và sử dụng quyền của dấu vân tay
// //*Bây giờ chúng ta hãy bắt đầu bằng cách thêm một số vật có thể thay thế
//   LocalAuthentication auth = LocalAuthentication();
//   bool? _canCheckBiometric;
//   //*Danh sách này sẽ lưu trữ tất cả các loại cảm biến sinh trắc học như vân tay, khuôn mặt, ...
//   List<BiometricType>? _availableBiometrics;
//   //*Đây là chuỗi sẽ nếu chúng tôi có thể đăng ký ứng dụng của mình hay không
//   String autherized = "Không được phép";

//   //*1 :Bây giờ, hãy tạo một chức năng cho phép chúng tôi kiểm tra cảm biến sinh trắc học của mình
//   //*Function: Chức năng kiểm tra mật khẩu
//   Future<void> _checkBiometric() async {
//     bool? canCheckBiometric;
//     try {
//       canCheckBiometric = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       _canCheckBiometric = canCheckBiometric;
//     });
//   }

//   //*2: bây giờ chúng tôi đã kiểm tra xem chúng tôi có được phép kiểm tra sinh trắc học của mình hay không,
//   //*Cảm biến sinh trắc học có sẵn trên thiết bị của chúng tôi
//   Future<void> _getAvailableBiometric() async {
//     List<BiometricType>? availableBiometric;
//     try {
//       availableBiometric = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       _availableBiometrics = availableBiometric;
//     });
//   }

//   //*3:Bây giờ, hãy mã hóa hàm chính sẽ cho phép chúng tôi xác thực
//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: "Quét ngón tay của bạn để xác thực",
//       );
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       autherized =
//           authenticated ? "Xác thực thành công" : "Không xác thực được";
//       print(authenticated);
//       //*lưu ý rằng bạn phải định cấu hình thiết bị và thêm dấu tay
//     });
//   }

//   //*->trước khi kiểm tra, trước tiên chúng ta nên khởi động trạng thái và gọi
//   //*->our two first function:hai chức năng đầu tiên của chúng tôi

//   @override
//   void initState() {
//     // TODO: implement initState
//     _checkBiometric();
//     _getAvailableBiometric();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xFF3C3E52),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text(
//                   "Login",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 48,
//                   ),
//                 ),
//               ),
//               Container(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 90,
//                       height: 90,
//                       child: Image.asset(
//                         'assets/images.png',
//                         width: 120,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(5),
//                     ),
//                     Text(
//                       "Xác thực vân tay",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       width: 150,
//                       child: Text(
//                         "Xác thực bằng vân tay thay vì mật khẩu của bạn",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           height: 1.5,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 15),
//                       width: double.infinity,
//                       child: ElevatedButton(
//                           //*-->Let's call our functionn
//                           onPressed: _authenticate,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 14, horizontal: 24),
//                             child: Text(
//                               "Xác thực",
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           )),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
