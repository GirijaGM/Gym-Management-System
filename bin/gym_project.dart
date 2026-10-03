import 'dart:io';

import '../lib/database/database.dart';
import '../lib/services/member_service.dart';
import '../lib/utils/validators.dart';

Future<void> main() async {
  final connection = await Database.connect();

  final memberService = MemberService(connection);

  while (true) {
    print('\n================================');
    print('      GYM MANAGEMENT SYSTEM');
    print('================================');
    print('1. Add Member');
    print('2. View Members');
    print('3. Search Member');
    print('4. Update Member');
    print('5. Delete Member');
    print('6. Exit');
    print('================================');

    stdout.write('Enter your choice: ');
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        await addMember(memberService);
        break;

      case '2':
        await memberService.viewMembers();
        break;

      case '3':
        await searchMember(memberService);
        break;

      case '4':
        await updateMember(memberService);
        break;

      case '5':
        await deleteMember(memberService);
        break;

      case '6':
        print('\nThank you for using Gym Management System! 👋');

        await connection.close();

        return;

      default:
        print('\nInvalid choice. Please try again.');
    }
  }
}
//add member
Future<void> addMember(MemberService memberService) async {
  print('\n========== ADD MEMBER ==========');

  stdout.write('Enter member name: ');
  String name = stdin.readLineSync()?.trim() ?? '';

  if (!Validators.isValidName(name)) {
    print('❌ Name cannot be empty.');
    return;
  }

  stdout.write('Enter phone: ');
  String phone = stdin.readLineSync()?.trim() ?? '';

  if (!Validators.isValidPhone(phone)) {
    print('❌ Phone number must contain exactly 10 digits.');
    return;
  }

  stdout.write('Enter email: ');
  String email = stdin.readLineSync()?.trim() ?? '';

  if (!Validators.isValidEmail(email)) {
    print('❌ Please enter a valid email.');
    return;
  }

  stdout.write('Enter gender (Male/Female): ');
  String gender = stdin.readLineSync()?.trim() ?? '';

  if (!Validators.isValidGender(gender)) {
    print('❌ Gender must be Male or Female.');
    return;
  }

  gender = gender[0].toUpperCase() +
      gender.substring(1).toLowerCase();

  stdout.write('Enter trainer ID: ');
  String trainerInput = stdin.readLineSync()?.trim() ?? '';

  int? trainerId = Validators.parseId(trainerInput);

  if (trainerId == null) {
    print('❌ Trainer ID must be a number.');
    return;
  }

  await memberService.addMember(
    name: name,
    phone: phone,
    email: email,
    gender: gender,
    trainerId: trainerId,
  );
}

//search member
Future<void> searchMember(MemberService memberService) async {
  print('\n========== SEARCH MEMBER ==========');

  stdout.write('Enter member name: ');
  String name = stdin.readLineSync() ?? '';

  await memberService.searchMember(name);
}

//update member
Future<void> updateMember(MemberService memberService) async {
  print('\n========== UPDATE MEMBER ==========');

  stdout.write('Enter member ID: ');
  int id = int.parse(stdin.readLineSync() ?? '0');

  stdout.write('Enter new phone: ');
  String phone = stdin.readLineSync() ?? '';

  stdout.write('Enter new email: ');
  String email = stdin.readLineSync() ?? '';

  await memberService.updateMember(
    id: id,
    phone: phone,
    email: email,
  );
}
//delete member
Future<void> deleteMember(MemberService memberService) async {
  print('\n========== DELETE MEMBER ==========');

  stdout.write('Enter member ID: ');
  int id = int.parse(stdin.readLineSync() ?? '0');

  await memberService.deleteMember(id);
}

