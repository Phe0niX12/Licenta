import 'package:flutter/material.dart';
import 'package:mobile_ui/model/mail.dart';
import 'package:mobile_ui/ui/event_editing_pange.dart';
import 'package:mobile_ui/widget/login_widget.dart';

class MailEditingPage extends StatefulWidget {
  final Mail? mail;

  const MailEditingPage({
    Key? key,
    this.mail
  }):super(key: key);

  @override
  State<MailEditingPage> createState() => _MailEditingPageState();
}

class _MailEditingPageState extends State<MailEditingPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime dateAndTimeSend;
  late DateTime dateAndTimeReminder;
  final subjectController = TextEditingController();
  final contentController = TextEditingController();
  final toController = TextEditingController();
  final ccController = TextEditingController();
  final bccController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(widget.mail == null){
      dateAndTimeSend = DateTime.now();
      dateAndTimeReminder = DateTime.now().add(Duration(days: 1));
    }else{
      final mail = widget.mail!;
      subjectController.text = mail.subject;
      dateAndTimeReminder = mail.dateAndTimeReminder;
      dateAndTimeSend = mail.dateAndTimeSend;
      contentController.text = mail.content;
      toController.text = mail.to;
      ccController.text = mail.cc;
      bccController.text = mail.bcc;
    }
  }

  @override
  void dispose(){
    super.dispose();
    subjectController.dispose();
    contentController.dispose();
    toController.dispose();
    ccController.dispose();
    bccController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(),
        ),
      body: Placeholder(),
    );
  }

   List<Widget> buildEditingActions() =>[
    ElevatedButton.icon( 
      onPressed: () {
        showModalBottomSheet(context: context,
        builder: (context) => LoginWidget()
        ); 
        },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent
      ),
      icon: Icon(Icons.check),
      label: Text("Save")    
    ),
  ];


  // Future saveForm() async{
  //   final isValid = _formKey.currentState!.validate();
  //   if(isValid){
  //     final mail = Mail(
  //       bcc: bccController.text,
  //       cc: ccController.text,
  //       subject: subjectController.text,
  //       content: contentController.text,
  //       userEmail: 
  //       )
  //   }
  // }
}