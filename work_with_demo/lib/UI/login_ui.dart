import 'package:flutter/material.dart';
import 'package:work_with_demo/LogIn/login_demo.dart';
import 'package:work_with_demo/UI/project_view.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 1.0, // 사진의 너비 비율 조정
              child: Container(
                margin: EdgeInsets.only(left: screenWidth * 0.2), // 왼쪽 거리 비율 조정
                child: Image.asset(
                  'image/test.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.1),

          Expanded(
            // 텍스트 필드로 어떤 정보들을 입력받는 화면을 구현할때 사용
              child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.teal,
                      inputDecorationTheme: const InputDecorationTheme(
                        // 입력창 위 라벨
                          labelStyle: TextStyle(
                              color: Colors.teal,
                              fontSize: 15.0
                          )
                      )
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: <Widget>[
                          TextField( // 입력 창 (ID)
                            controller: usernameController, // 연결된 TextEditingController
                            decoration: const InputDecoration(
                                labelText: 'Username' // 라벨
                            ),
                          ),

                          const SizedBox(height: 15.0,),

                          TextField( // 입력 창 (password)
                            controller: passwordController, // 연결된 TextEditingController
                            decoration: const InputDecoration(
                                labelText: 'Password' // 라벨
                            ),
                            obscureText: true,  // 입력한 텍스트 숨기기
                          ),

                          const SizedBox(height: 40.0,),

                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                backgroundColor: Colors.teal,
                                minimumSize: const Size(100, 50),
                              ),
                              onPressed: () async {
                                String username = usernameController.text;
                                String password = passwordController.text;

                                bool loginSuccess = await login(username, password, context); // 컨트롤러에서 텍스트를 가져와 함수를 호출

                                if (loginSuccess) {
                                  // If login is successful, navigate to the next page
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => const ViewProjectPage())
                                  );
                                }
                              },
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ],
                      )
                  )
              )
          )
        ],
      ),
    );
  }
}