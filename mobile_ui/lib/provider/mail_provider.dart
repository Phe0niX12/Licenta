import 'package:flutter/material.dart';
import 'package:mobile_ui/database/database_helper.dart';
import 'package:mobile_ui/model/mail.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class MailProvider extends ChangeNotifier{
  final List<Mail> _mails = [];

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  MailProvider(){
    loadMails();
  }

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

  Future<void> loadMails() async {
    _mails.clear();
    final mailList = await _databaseHelper.mails();
    _mails.addAll(mailList);
    notifyListeners();
  }

  Future<void> addMail(Mail mail) async {
    await _databaseHelper.insertMail(mail);
    _mails.add(mail);
    notifyListeners();
  }

  Future<void> deleteMail(Mail mail) async {
    await _databaseHelper.deleteMail(mail.id);
    _mails.removeWhere((element) => element.id == mail.id);
    notifyListeners();
  }

  Future<void> editMail(Mail newMail, Mail oldMail) async {
    await _databaseHelper.updateMail(newMail);
    final index = _mails.indexOf(oldMail);
    _mails[index] = newMail;
    notifyListeners();
  }


}