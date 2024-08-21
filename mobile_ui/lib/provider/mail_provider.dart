import 'package:flutter/material.dart';
import 'package:mobile_ui/model/mail.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class MailProvider extends ChangeNotifier{
  final List<Mail> _mails = [];

  List<Mail> get mails => _mails;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Mail> get mailsOfSelectedDate => _mails;

  late String _userEmail;
  late String _userPassword;

  void setEmail(String userEmail) => _userEmail = userEmail;

  void setPassword(String userPassword) => _userPassword = userPassword;

  String get userEmail => _userEmail;

  String get userPassword => _userPassword;

  

  void addMail(Mail mail){
    
    _mails.add(mail);
    notifyListeners();
  }

  void deleteMail(Mail mail){
    _mails.removeWhere((element) => element == mail,);
    notifyListeners();
  }

  void editMail(Mail newMail, Mail oldMail){
    final index = _mails.indexOf(oldMail);
    _mails[index]= newMail;
    notifyListeners();
  }


}