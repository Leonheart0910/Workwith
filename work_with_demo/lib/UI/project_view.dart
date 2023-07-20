import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_with_demo/project_format/project_format_demo.dart';
import 'package:work_with_demo/add_project/popup_window.dart';

class ViewProjectPage extends StatefulWidget {
  const ViewProjectPage({super.key});

  @override
  State<ViewProjectPage> createState() => _ViewProjectPageState();
}

class _ViewProjectPageState extends State<ViewProjectPage> {
  bool _showEndedProjects = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft, // 텍스트를 왼쪽 정렬
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01), // 오른쪽 패딩을 비율로 조정
            child: const Text('Test'),
          ),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('나중에 Callendar로 바꿀 부분!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Callendar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('나중에 Task로 바꿀 부분!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Task'),
          ),
        ],
      ),
      body: Consumer<ProjectModel>(
        builder: (context, projectModel, child) {
          return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _showEndedProjects = !_showEndedProjects;
                          });
                        },
                        child: Text(_showEndedProjects ? '완료된 프로젝트' : '참가중인 프로젝트')),
                    TextButton(
                        onPressed: () {
                          showNewProjectPopup(context);
                        },
                        child: const Text('New Project')),
                    TextButton(
                        onPressed: () {
                          showJoinPopup(context);
                        },
                        child: const Text('Join in'))
                  ],
                ),
                SizedBox(
                  width: 500,
                  height: 500,
                  child: ListView.builder(
                    itemCount: _showEndedProjects ? projectModel.endProjects.length + 1 : projectModel.projects.length + 1,
                    itemBuilder: (context, index) {
                      final listToShow = _showEndedProjects ? projectModel.endProjects : projectModel.projects;
                      if (index == listToShow.length){
                        return IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => showNewProjectPopup(context),
                        );
                      }
                      return ListTile(
                        title: Text(listToShow[index].title.toString()),
                        subtitle:
                        Text(listToShow[index].detail.toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
