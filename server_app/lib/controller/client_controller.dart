import 'package:server_app/server_app.dart';
import 'package:server_app/model/client.dart';

class ClientController extends ResourceController {
  ManagedContext context;
  ClientController(this.context);

  @Operation.get()
  Future<Response> getAllClients() async {
    final query = Query<Client>(context);
    final clientsList = await query.fetch();
    return Response.ok(clientsList);
  }

  @Operation.get('id')
  Future<Response> qetClientById(@Bind.path('id') int id) async {
    final query = Query<Client>(context)..where((c) => c.id).equalTo(id);
    final client = await query.fetchOne();

    if (client == null) {
      return Response.notFound();
    }
    return Response.ok(client);
  }

  @Operation.post()
  Future<Response> addClient(@Bind.body() Client newClient) async {
    final query = Query<Client>(context)..values = newClient;
    final insertedClient = await query.insert();
    return Response.ok(insertedClient);
  }

  @Operation.put('id')
  Future<Response> updateClientById(@Bind.path('id') int id,
      @Bind.body(ignore: ['id']) Client clientUpdate) async {
    final query = Query<Client>(context)
      ..values = clientUpdate
      ..where((c) => c.id).equalTo(id);
    final updatedClient = await query.updateOne();

    if (updatedClient == null) {
      return Response.notFound();
    }
    return Response.ok(updatedClient);
  }

  @Operation.delete('id')
  Future<Response> deleteClientById(@Bind.path('id') int id) async {
    final query = Query<Client>(context)..where((c) => c.id).equalTo(id);
    final client = await query.fetchOne();
    final deletedClient = await query.delete();

    if (deletedClient == 0) {
      return Response.notFound();
    }
    return Response.ok(client);
  }
}
