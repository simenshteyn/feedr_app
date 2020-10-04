import 'package:feedr_app/controller/worker_controller.dart';

import 'feedr_app.dart';

class FeedrAppChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final config = FeedrConfig(options.configurationFilePath);
    final database = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName,
    );

    context = ManagedContext(dataModel, database);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });
    router.route("worker/[:id]").link(() => WorkerController(context));

    return router;
  }
}

class FeedrConfig extends Configuration {
  FeedrConfig(String path) : super.fromFile(File(path));
  DatabaseConfiguration database;
}
