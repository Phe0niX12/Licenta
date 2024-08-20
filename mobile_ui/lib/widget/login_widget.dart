import 'package:flutter/material.dart';
import 'package:mobile_ui/provider/mail_provider.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {


  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MailProvider>(context);
    
    return const Placeholder();
  }
}