# medal

Medal (Memo+Calendar) for DX sprint 2023

# 2023/07/13
- 로그인 화면 작업
- 로그인 UI 객체화
- UI 수정

# 2023/07/14
- 로그인 화면 UI 작업 완료
- 달력 화면 UI 프로토타입

# 2023/07/15
- 달력 UI 구체화, 하지만 객체화가 안되어 수정 요

# 2023/07/16
- previous 파일 내에 전에 했던 UI 작업 참고용으로 저장
- //inventory 파일 내에 작업 2개, UI 필요
- 달력 UI & 메모장 데모 완성

# 2023/07/17
- LogIn UI & Main UI 파일 연결

# 2023/07/18
- LogIn Demo : 기능 구현
    - API 통신 요청까지만 구현되어 BE 작업과 연동 필요
- 임시로 프로젝트 참가, 생성 -> 프로젝트 목록 확인하는 페이지까지 만들어 연결

# 2023/07/19
- test_app : Flutter을 통한 Web socket 통신 테스트
- socket & login_demo :
    - socket : 8081 -> web socket 로컬 서버, 8090 -> 로그인 HTTP 로컬 서버
    - login_demo : 로컬 서버 8090과의 통신으로 수신-응답이 제대로 이루어졌을때 ViewProjectPage로 넘어가도록 수정

# 2023/07/20
- 서버 연결 실패시 SnackBar가 안뜨던 오류를 수정함
- 참가중인 프로젝트 버튼 추가
    - 누르면 ProjectModel에 저장된 _endedProjects(완료된 프로젝트 목록)을 출력
    - _projects <-> _endedProjects에 따라 텍스트 버튼의 텍스트도 바뀌도록 구현
- 작업 파일명 work_with_demo로 변경

# 2023/07/21
- 웹 기반에서 앱 기반으로 변경
- medal 앱 기반 완성
