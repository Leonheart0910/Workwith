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
  final List<Project> _endedProjects = [
    Project(id: 9999, title: 'E1', detail: 'Ended Project1'),
    Project(id: 9998, title: 'E2', detail: 'Ended Project2'),
    Project(id: 9997, title: 'E3', detail: 'Ended Project3'),
    Project(id: 9996, title: 'E4', detail: 'Ended Project4')
  ];

  List<Project> get projects => _projects;
  List<Project> get endProjects => _endedProjects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }
}