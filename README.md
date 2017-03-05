# protobuf_runner

Builds Dart protocol buffers.

## Example:

Make a protobuf file:

```proto
syntax = "proto2";

package address_book;

message Person {
    required string name = 1;
    required int32 id = 2;
    optional string email = 3;

    enum PhoneType {
        MOBILE = 0;
        HOME = 1;
        WORK = 2;
    }

    message PhoneNumber {
        required string number = 1;
        optional PhoneType type = 2 [default = HOME];
    }

    repeated PhoneNumber phones = 4;
}

message AddressBook {
    repeated Person people = 1;
}

```

Run the command:

```bash
pbuf address_book.proto
```

Enjoy your new Protocol Buffer!

```dart
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
```

## Getting Started:

Install the latest `protoc` command:

```bash
brew install protoc
```

Install dart_protoc_plugin on your machine:
 
```bash
git clone git@github.com:dart-lang/dart-protoc-plugin.git
cd dart-protoc-plugin
pub get
```

Install this tool:

```bash
pub global activate protobuf_runner
```

## Usage


Option 1: using the `DART_PROTOC_PLUGIN` environment variable:

```bash
export DART_PROTOC_PLUGIN=/path/to/dart-protoc-plugin 
pbuf /path/to/project/lib/address_book.proto
```

Option 2: using the `--plugin` flag:

```bash
pbuf --plugin=/path/to/dart-protoc-plugin /path/to/project/lib/address_book.proto
```

## Contributing

to install locally: 
```bash
pub global activate --source path  /path/to/protobuf_runner/
```

## Issues

Please use the [Issue Tracker][issues]

[issues]: https://github.com/johnpryan/dart-protobuf-runner/issues