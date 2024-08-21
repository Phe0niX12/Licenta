
import 'package:flutter/material.dart';
import 'package:mobile_ui/model/calendar_item.dart';
import 'package:uuid/uuid.dart';

class Event implements CalendarItem{
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final String id;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.from, 
    required this.to, 
    this.backgroundColor = const Color.fromARGB(255, 135, 3, 3),

     });
     
  @override
  DateTime getEndTime() {
    return this.to;
  }

  @override
  DateTime getStartTime() {
    return this.from;
  }

  @override
  String getTitle() {
    return this.title;
  }
  @override
  Color getColor() {
    return this.backgroundColor;
  }

  Map<String, dynamic> toMap() {
    
    return {
      'id': id,
      'title': title,
      'description': description,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'backgroundColor': backgroundColor.value,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      from: DateTime.parse(map['from']),
      to: DateTime.parse(map['to']),
      backgroundColor: Color(map['backgroundColor']),
    );
  }
}