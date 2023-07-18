import 'package:flutter/foundation.dart';

class Project {
  int? id; // Project code
  String? title; // Project title
  String? detail; // Project detail

  Project({this.id, this.title, this.detail});

  // parse SampleModel from json
  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
  }

  // parse SampleModel to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    return data;
  }
}

class ProjectModel with ChangeNotifier {
  final List<Project> _projects = [];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }
}