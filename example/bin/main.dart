import 'package:dart_protobuf_example/address_book.pb.dart';

main() {
  var people = [
    new Person()..name = "Jack Ryan"..email = "jack.ryan@gmail.com",
    new Person()..name = "Brad Ryan"..email = "brad.ryan@gmail.com"
  ];
  var x = new AddressBook();
  x.people.addAll(people);
  print(x.writeToJson());
}