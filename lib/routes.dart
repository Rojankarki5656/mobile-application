import 'package:lab2nd/pages/chatapp/chats.dart';
import 'package:lab2nd/pages/chatapp/conversations.dart';
import 'package:lab2nd/pages/demo/login.dart';
import 'package:lab2nd/pages/maps/maps.dart';
import 'package:lab2nd/pages/pages/dashboard.dart';
import 'package:lab2nd/pages/pages/detailpage.dart';
import 'package:lab2nd/payments/esewa_payment.dart';

class AppRoute{
  AppRoute._();
  static const String loginpageroute = '/login';
  static const String dashboardPageroute = '/dashboard';
  static const String detailPage = '/detailpage';
  static const String mapspage = '/mapspage';
  static const String esewa = '/esewa';
  static const String chatpage = '/chatpage';
  static const String conversationpage = '/conversation';

  static getAppRoutes()=>{
    loginpageroute: (context) => loginPage(),
    dashboardPageroute: (context) => const dashboard(),
    detailPage: (context) => const detailpage(),
    mapspage: (context) => const MapsApp(),
    esewa: (context) => const EsewaApp(title: "Payment"),
    chatpage: (context) => const chats(),
    conversationpage: (context) => const Conversations(),
  };
}