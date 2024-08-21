import 'package:flutter/material.dart';
import 'package:mobile_ui/model/calendar_item.dart';
import 'package:uuid/uuid.dart';

class Mail implements CalendarItem {
  final String subject;
  final String content;
  final String userEmail;
  final String userPassword;
  final String to;
  final Color backgroundColor;
  final DateTime dateAndTimeSend;
  final String cc;
  final String bcc;
  final String id;
  final DateTime dateAndTimeReminder;

  Mail({
    required this.subject,
    required this.content,
    required this.userEmail,
    required this.userPassword,
    required this.to, 
    required this.dateAndTimeSend,
    required this.cc,
    required this.bcc,
    required this.id,
    required this.dateAndTimeReminder,

    this.backgroundColor = const Color.fromARGB(255, 104, 8, 93),

     });
     
  @override
  DateTime getEndTime() {
    return this.dateAndTimeSend.add(Duration(minutes: 30));
  }

  @override
  DateTime getStartTime() {
    return this.dateAndTimeSend;
  }

  @override
  String getTitle() {
    return this.subject;
  }

  @override
  Color getColor() {
      return this.backgroundColor;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'content': content,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'to': to,
      'backgroundColor': backgroundColor.value,
      'dateAndTimeSend': dateAndTimeSend.toIso8601String(),
      'cc': cc,
      'bcc': bcc,
      'dateAndTimeReminder': dateAndTimeReminder.toIso8601String(),
    };
  }
  factory Mail.fromMap(Map<String, dynamic> map) {
    return Mail(
      subject: map['subject'],
      content: map['content'],
      userEmail: map['userEmail'],
      userPassword: map['userPassword'],
      to: map['to'],
      backgroundColor: Color(map['backgroundColor']),
      dateAndTimeSend: DateTime.parse(map['dateAndTimeSend']),
      cc: map['cc'],
      bcc: map['bcc'],
      id: map['id'],
      dateAndTimeReminder: DateTime.parse(map['dateAndTimeReminder']),
    );
  }
  
}