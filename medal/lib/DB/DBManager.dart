import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static final DBManager _instance = DBManager._(); // DBManager 클래스의 싱글톤 객체 생성
  static Database? _database; // 데이터베이스 인스턴스를 저장하는 변수
  // 스키마(schema) -> 데이터베이스에 저장되는 데이터의 구조와 제약조건을 정의한 것
  // 인스턴스(instance) -> 정의된 스키마에 따라 데이터베이스에 실제로 저장된 값

  DBManager._(); // DBManager 생성자(private)

  factory DBManager() => _instance; // DBManager 인스턴스 반환 메소드

  // 데이터베이스 인스턴스를 가져오는 메소드
  Future<Database> get database async {
    if (_database != null) {
      // 인스턴스가 이미 존재한다면
      return _database!; // 저장된 데이터베이스 인스턴스를 반환
    }
    _database = await _initDB(); // 데이터베이스 초기화
    return _database!; // 초기화된 데이터베이스 인스턴스 반환
  }

  // 데이터베이스 초기화 메소드
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath(); // 데이터베이스 경로 가져오기
    final path = join(dbPath, 'memos.db'); // 데이터베이스 파일 경로 생성 -> 메모를 생성할 것이므로 파일 이름 : memos
    return await openDatabase(
      path, // 데이터베이스 파일 경로
      version: 1, // 데이터베이스 버전
      onCreate: (db, version) async {
        await db.execute(
          // SQL 쿼리를 실행하여 데이터베이스 테이블 생성
          '''
            CREATE TABLE memos(
              id INTEGER PRIMARY KEY, 
              title TEXT, 
              detail INTEGER, 
              start_year INTEGER, 
              start_mon INTEGER, 
              start_day INTEGER, 
              end_year INTEGER, 
              end_mon INTEGER, 
              end_day INTEGER
            )
          ''',
          // id : 테이블의 기본 키, title : 제목, detail : 메모(세부 사항), start_ : 시작 날짜 값, end_ : 마감 날짜 값
        );
      },
    );
  }

  // 데이터 추가 메소드
  Future<void> insertData(
      String title, String detail, int sYear, int sMon, int sDay, int eYear, int eMon, int eDay
    ) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.insert(
      'memos', // 데이터를 추가할 테이블 이름
      {
        'title': title,
        'detail': detail,
        'start_year': sYear,
        'start_mon': sMon,
        'start_day': sDay,
        'end_year': eYear,
        'end_mon': eMon,
        'end_day': eDay
      }, // 추가할 데이터
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복 데이터 처리 방법 설정
    );
  }

  // 데이터 조회 메소드
  Future<List<Map<String, dynamic>>> selectData() async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    return await db.query('memos'); // 데이터베이스에서 모든 데이터 조회
  }

  // 데이터 수정 메소드
  Future<void> updateData(  // id에 대한 정보까지
      int id, String title, String detail, int sYear, int sMon, int sDay, int eYear, int eMon, int eDay
    ) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.update(
      'memos', // 수정할 테이블 이름
      {
        'title': title,
        'detail': detail,
        'start_year': sYear,
        'start_mon': sMon,
        'start_day': sDay,
        'end_year': eYear,
        'end_mon': eMon,
        'end_day': eDay
      }, // 수정할 데이터
      where: 'id = ?', // 수정할 데이터의 조건 설정
      whereArgs: [id], // 수정할 데이터의 조건 값
    );
  }
  // 데이터 삭제 메소드
  Future<void> deleteData(int id) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.delete(
      'memos', // 삭제할 테이블 이름
      where: 'id = ?', // 삭제할 데이터의 조건 설정
      whereArgs: [id], // 삭제할 데이터의 조건 값
    );
  }
}