import 'dart:async';
import "package:args/args.dart";
import "package:args/command_runner.dart";
import "package:path/path.dart" as path;
import "dart:io" as io;

const String pluginFlag = "DART_PROTOC_PLUGIN";

main(List<String> arguments) async {
  await new ProtoCommandRunner().run(arguments);
}

/// the pbuf command.
class ProtoCommandRunner extends CommandRunner {
  ProtoCommandRunner()
      : super("pbuf", "a tool that generates Protocol Buffers for Dart") {
    argParser.addOption("plugin",
        abbr: "p", help: "path to dart-protoc-plugin");
    argParser.addOption("project",
        help: "path to the project containing .proto files");
  }

  Future runCommand(ArgResults options) async {
    // Require a path to a .pbuf file.
    if (options.rest.length != 1) {
      printUsage();
      return;
    }

    // Determine the plugin directory, which can be set using --plugin or
    // through an environment variable
    var protocPluginDirectory =
        io.Platform.environment[pluginFlag] ?? options["plugin"];

    if (protocPluginDirectory == null) {
      io.stderr.write(
          "A plugin directory must be provided. Use \$$pluginFlag or --plugin");
      io.exit(1);
    }

    // Allow for relative paths; parse the path and append it to the current path
    var context = new path.Context(
        style: path.Style.platform, current: io.Directory.current.toString());
    var protoPathStr = options.rest.first;
    String protoPath;
    if (context.isAbsolute(protoPathStr)) {
      protoPath = protoPathStr;
    } else {
      var currentComponents = path.split(io.Directory.current.path);
      var relativeComponents = path.split(protoPathStr);
      protoPath =
          context.joinAll(currentComponents..addAll(relativeComponents));
    }

    // Determine the protocol buffer's project directory
    String projectDirectory;
    if (options["project"] == null) {
      // Assume the project directory is the directory of the .proto file
      var c = context.split(protoPath)..removeLast();
      projectDirectory = context.joinAll(c);
    } else {
      projectDirectory = options["project"];
    }

    // Add the plugin directory to the PATH variable.
    var envVars = io.Platform.environment;
    var protocEnv = new Map.from(envVars)
      ..addAll({"PATH": "$protocPluginDirectory:${envVars["PATH"]}"});

    // Run the `protoc` command.
    var result = await io.Process.run(
        "protoc",
        [
          "--dart_out=$projectDirectory",
          "--proto_path=$projectDirectory",
          "$protoPath"
        ],
        workingDirectory: protocPluginDirectory,
        environment: protocEnv);

    io.stdout.write(result.stdout);
    io.stderr.write(result.stderr);
  }
}

