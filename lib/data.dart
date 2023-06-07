// ignore_for_file: unused_import

part of 'exchange.dart';

abstract class Data{

  void load(String fileName);

  void save(String fileName);

  void clear();

  bool get hasData;

  String get data;

  set data(String value);

  List<String> get fields;
  
}