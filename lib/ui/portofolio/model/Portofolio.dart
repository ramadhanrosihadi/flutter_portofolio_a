import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/api/model/firebase/firebase_state.dart';
import 'package:flutter_starter_b/common/util/VFireStore.dart';

class Portofolio {
  final String title;
  final String description;
  final int year;
  final String start_at;
  final String end_at;
  final String client_name;
  final String stacks_string;
  final String type;
  final List<String> screenshot_urls;
  Portofolio({
    this.title,
    this.description,
    this.year,
    this.start_at,
    this.end_at,
    this.client_name,
    this.stacks_string,
    this.type,
    this.screenshot_urls,
  });

  Portofolio copyWith({
    String title,
    String description,
    int year,
    String start_at,
    String end_at,
    String client_name,
    String stacks_string,
    String type,
    List<String> screenshot_urls,
  }) {
    return Portofolio(
      title: title ?? this.title,
      description: description ?? this.description,
      year: year ?? this.year,
      start_at: start_at ?? this.start_at,
      end_at: end_at ?? this.end_at,
      client_name: client_name ?? this.client_name,
      stacks_string: stacks_string ?? this.stacks_string,
      type: type ?? this.type,
      screenshot_urls: screenshot_urls ?? this.screenshot_urls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'year': year,
      'start_at': start_at,
      'end_at': end_at,
      'client_name': client_name,
      'stacks_string': stacks_string,
      'type': type,
      'screenshot_urls': screenshot_urls,
    };
  }

  factory Portofolio.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Portofolio(
      title: map['title'],
      description: map['description'],
      year: map['year']?.toInt(),
      start_at: map['start_at'],
      end_at: map['end_at'],
      client_name: map['client_name'],
      stacks_string: map['stacks_string'],
      type: map['type'],
      screenshot_urls: List<String>.from(map['screenshot_urls'] != null ? map['screenshot_urls'] : []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Portofolio.fromJson(String source) => Portofolio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Portofolio(title: $title, description: $description, year: $year, start_at: $start_at, end_at: $end_at, client_name: $client_name, stacks_string: $stacks_string, type: $type, screenshot_urls: $screenshot_urls)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Portofolio &&
        o.title == title &&
        o.description == description &&
        o.year == year &&
        o.start_at == start_at &&
        o.end_at == end_at &&
        o.client_name == client_name &&
        o.stacks_string == stacks_string &&
        o.type == type &&
        listEquals(o.screenshot_urls, screenshot_urls);
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ year.hashCode ^ start_at.hashCode ^ end_at.hashCode ^ client_name.hashCode ^ stacks_string.hashCode ^ type.hashCode ^ screenshot_urls.hashCode;
  }

  void insertToFireStore() {
    CollectionReference collectionReference = Firestore.instance.collection('portofolio');
    collectionReference.add(this.toMap());
  }

  Portofolio fromDoc(DocumentSnapshot documentSnapshot) {
    return Portofolio.fromMap(documentSnapshot.data());
  }

  Future<List<Portofolio>> fetchFromFireStore() async {
    CollectionReference collectionReference = Firestore.instance.collection('portofolio');
    QuerySnapshot collectionSnapshot = await collectionReference.get();
    List<Portofolio> newDatas = [];
    collectionSnapshot.docs.asMap().forEach((key, value) {
      newDatas.add(Portofolio.fromMap(value.data()));
    });
    return newDatas;
  }

  final StreamController<FirebaseState> _stateController = StreamController<FirebaseState>.broadcast();
  Stream<FirebaseState> get state => _stateController.stream;

  Future fetch() async {
    _stateController.add(FirebaseState(stateCode: StateCode.LOADING));
    // List<Portofolio> datas = await fetchFromFireStore();
    List<DocumentSnapshot> datas = await VFireStore.fetchDocs('portofolio');
    _stateController.add(FirebaseState(stateCode: StateCode.SUCCESS, data: datas));
  }
}
