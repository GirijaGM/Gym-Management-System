class Member {
  int id;
  String name;
  String phone;
  String email;
  String gender;

  Member({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
  });

  void display(){
    print("Member Id $id");
    print("Name $name");
    print("Phone $phone");
    print("Email $email");
    print("Gender $gender");
  }

}