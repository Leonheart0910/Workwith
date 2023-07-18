import 'package:http/http.dart' as http;

Future<void> sendProjectData(String title, String detail) async {
  final response = await http.post(
    Uri.parse('https://your-server.com/data'), // Update this with your server URL
    body: {
      'title': title,
      'detail': detail
    },
  );
  if (response.statusCode == 200) {
    print('Data sent successfully');
  } else {
    throw Exception('Failed to send data');
  }
}

Future<void> sendJoinCodeData(String joinId) async {
  final response = await http.post(
    Uri.parse('https://your-server.com/data'), // Update this with your server URL
    body: {
      'joinId' : joinId
      // 아마 userId 도 보내야될듯
    },
  );
  if (response.statusCode == 200) {
    print('Data sent successfully');
  } else {
    throw Exception('Failed to send data');
  }
}