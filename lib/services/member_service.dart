import 'package:mysql_client/mysql_client.dart';

class MemberService {
  final MySQLConnection connection;

  MemberService(this.connection);

  // ADD MEMBER
  Future<void> addMember({
    required String name,
    required String phone,
    required String email,
    required String gender,
    required int trainerId,
  }) async {
    await connection.execute(
      '''
      INSERT INTO members
      (member_name, phone_number, email, gender, join_date, trainer_id)
      VALUES (:name, :phone, :email, :gender, CURDATE(), :trainerId)
      ''',
      {
        'name': name,
        'phone': phone,
        'email': email,
        'gender': gender,
        'trainerId': trainerId,
      },
    );

    print('\nMember added successfully! ✅');
  }

  // VIEW MEMBERS
  Future<void> viewMembers() async {
    final result = await connection.execute(
      'SELECT * FROM members',
    );

    print('\n========== ALL MEMBERS ==========');

    if (result.rows.isEmpty) {
      print('No members found.');
      return;
    }

    for (final row in result.rows) {
      print('------------------------------');
      print('Member ID : ${row.assoc()['member_id']}');
      print('Name      : ${row.assoc()['member_name']}');
      print('Phone     : ${row.assoc()['phone_number']}');
      print('Email     : ${row.assoc()['email']}');
      print('Gender    : ${row.assoc()['gender']}');
      print('Join Date : ${row.assoc()['join_date']}');
      print('Trainer ID: ${row.assoc()['trainer_id']}');
    }

    print('------------------------------');
  }

  // SEARCH MEMBER
  Future<void> searchMember(String name) async {
    final result = await connection.execute(
      '''
      SELECT * FROM members
      WHERE member_name LIKE :name
      ''',
      {
        'name': '%$name%',
      },
    );

    print('\n========== SEARCH RESULT ==========');

    if (result.rows.isEmpty) {
      print('Member not found.');
      return;
    }

    for (final row in result.rows) {
      print('------------------------------');
      print('Member ID : ${row.assoc()['member_id']}');
      print('Name      : ${row.assoc()['member_name']}');
      print('Phone     : ${row.assoc()['phone_number']}');
      print('Email     : ${row.assoc()['email']}');
      print('Gender    : ${row.assoc()['gender']}');
      print('Join Date : ${row.assoc()['join_date']}');
      print('Trainer ID: ${row.assoc()['trainer_id']}');
    }
  }

  // UPDATE MEMBER
  Future<void> updateMember({
    required int id,
    required String phone,
    required String email,
  }) async {
    final result = await connection.execute(
      '''
      UPDATE members
      SET phone_number = :phone,
          email = :email
      WHERE member_id = :id
      ''',
      {
        'phone': phone,
        'email': email,
        'id': id,
      },
    );

    if (result.affectedRows > BigInt.zero) {
      print('\nMember updated successfully! ✅');
    } else {
      print('\nMember not found.');
    }
  }

  // DELETE MEMBER
  Future<void> deleteMember(int id) async {
    final result = await connection.execute(
      '''
      DELETE FROM members
      WHERE member_id = :id
      ''',
      {
        'id': id,
      },
    );

    if (result.affectedRows > BigInt.zero) {
      print('\nMember deleted successfully! ✅');
    } else {
      print('\nMember not found.');
    }
  }
}