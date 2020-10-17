import 'package:server_app/server_app.dart';
import 'package:server_app/model/servant.dart';

class ServantController extends ResourceController {
  ManagedContext context;
  ServantController(this.context);

  @Operation.get()
  Future<Response> getAllServants() async {
    final query = Query<Servant>(context);
    final servantList = await query.fetch();
    return Response.ok(servantList);
  }

  @Operation.get('id')
  Future<Response> getServantById(@Bind.path('id') int id) async {
    final query = Query<Servant>(context)..where((w) => w.id).equalTo(id);
    final servant = await query.fetchOne();

    if (servant == null) {
      return Response.notFound();
    }
    return Response.ok(servant);
  }

  @Operation.post()
  Future<Response> addServant(
      @Bind.body(ignore: ['id']) Servant newServant) async {
    final query = Query<Servant>(context)..values = newServant;
    final insertedServant = await query.insert();
    return Response.ok(insertedServant);
  }

  @Operation.put('id')
  Future<Response> updateServantById(@Bind.path('id') int id,
      @Bind.body(ignore: ['id']) Servant servantUpdate) async {
    final query = Query<Servant>(context)
      ..values = servantUpdate
      ..where((w) => w.id).equalTo(id);
    final updatedServant = await query.updateOne();

    if (updatedServant == null) {
      return Response.notFound();
    }
    return Response.ok(updatedServant);
  }

  @Operation.delete('id')
  Future<Response> deleteServantById(@Bind.path('id') int id) async {
    final query = Query<Servant>(context)..where((w) => w.id).equalTo(id);
    final servant = await query.fetchOne();
    final deletedServant = await query.delete();

    if (deletedServant == 0) {
      return Response.notFound();
    }
    return Response.ok(servant);
  }
}
