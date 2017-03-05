# protobuf_runner

Builds Dart protocol buffers.

## Installation:

Install dart_protoc_plugin on your machine and run `pub get`.

then install this command using `pub global activate protobuf_runner`

## Usage

using the `DART_PROTOC_PLUGIN` environment variable:

```
export DART_PROTOC_PLUGIN=/path/to/dart-protoc-plugin 
pbuf /path/to/project/lib/address_book.proto
```

using the `--plugin` flag:

```
pbuf --plugin=/path/to/dart-protoc-plugin /path/to/project/lib/address_book.proto
```

## Contributing

to install locally: 
```
pub global activate --source path  /path/to/protobuf_runner/
```
