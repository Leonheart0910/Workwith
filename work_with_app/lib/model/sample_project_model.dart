import 'package:flutter/foundation.dart';

class Project {
  int? id; // Project code
  String? title; // Project title
  String? detail; // Project detail
  bool _status; // Project Status

  Project({this.id, this.title, this.detail, bool status = true})
      : _status = status;


  endProject() {_status = false;}

  printProjectStatus() {
    print('ID : #$id');
    print('title : $title');
    print('detail : $detail');
    if (_status) {print('-> Project is ongoing.');}
    else {print('-> Ended Project.');}
  }
}

class SampleProjects with ChangeNotifier {
  final List<Project> _projects = [
    Project(id: 0001, title: 'test1', detail: 'For testing project model'),
    Project(id: 0002, title: 'test2', detail: 'For testing project model'),
    Project(id: 0003, title: 'test3', detail: 'For testing project model'),
    Project(id: 0004, title: 'test4', detail: 'For testing project model'),
  ];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }
}

class SampleEndProjects with ChangeNotifier {
  final List<Project> _endProjects = [
    Project(id: 9996, title: 'end1', detail: 'For testing project model', status: false),
    Project(id: 9997, title: 'end2', detail: 'For testing project model', status: false),
    Project(id: 9998, title: 'end3', detail: 'For testing project model', status: false),
    Project(id: 9999, title: 'end4', detail: 'For testing project model', status: false),
  ];

  List<Project> get endProjects => _endProjects;

  void addProject(Project project) {
    _endProjects.add(project);
    notifyListeners();
  }
}

// void testing() {
//   SampleProjects sampleProjects = SampleProjects();
//   SampleEndProjects sampleEndProjects = SampleEndProjects();
//
//   print("Projects:");
//   for (var project in sampleProjects.projects) {
//     project.printProjectStatus();
//   }
//
//   print("Ended Projects:");
//   for (var project in sampleEndProjects.endProjects) {
//     project.printProjectStatus();
//   }
// }
// void main() {
//   testing();
// }
