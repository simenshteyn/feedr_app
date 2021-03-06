import 'package:server_app/controller/servant_controller.dart';
import 'package:server_app/controller/vote_controller.dart';
import 'package:server_app/controller/client_controller.dart';
import 'package:server_app/controller/feedback_controller.dart';
import 'package:server_app/controller/link_controller.dart';

import 'package:server_app/server_app.dart';

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
    router.route("servant/[:id]").link(() => ServantController(context));

    router.route("vote/[:id]").link(() => VoteController(context));

    router.route("link/[:link]").link(() => LinkController(context));

    router.route("client/[:id]").link(() => ClientController(context));

    router.route("feedback/[:id]").link(() => FeedbackController(context));

    return router;
  }
}

class FeedrConfig extends Configuration {
  FeedrConfig(String path) : super.fromFile(File(path));
  DatabaseConfiguration database;
}
