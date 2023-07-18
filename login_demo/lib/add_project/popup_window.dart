import 'package:flutter/material.dart';
import 'package:login_demo/project_format/project_format_demo.dart';
import 'package:login_demo/add_project/add_new_project.dart';
import 'package:provider/provider.dart';

void showNewProjectPopup(BuildContext context) {

  final titleController = TextEditingController();
  final detailController = TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('새 프로젝트 생성'),
          content: Column(
            children: <Widget>[
              SizedBox(
                width: 600.0,
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' 프로젝트 이름',
                  ),
                ),
              ),
              SizedBox(
                width: 600.0,
                height: 600.0,
                child: TextField(
                  controller: detailController,
                  maxLines: 30,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' 프로젝트 내용을 입력하세요',
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('추가하기'),
              onPressed: () {
                Project newProject = Project(
                  title: titleController.text,
                  detail: detailController.text,
                );  // 새로운 프로젝트 객체 생성
                // Add the project to the project list
                Provider.of<ProjectModel>(context, listen: false).addProject(newProject);

                // 새로 생성된 Project 객체를 HTTP 통신으로 서버에 전송
                sendProjectData(titleController.text, detailController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

void showJoinPopup(BuildContext context) {
  final joinCodeController = TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('참가하기'),
          content: Column(
            children: <Widget>[
              SizedBox(
                width: 600.0,
                child: TextField(
                  controller: joinCodeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' 프로젝트 코드',
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('참가하기'),
              onPressed: () {
                sendJoinCodeData(joinCodeController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

