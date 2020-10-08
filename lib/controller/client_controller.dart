import 'package:feedr_app/feedr_app.dart';
import 'package:feedr_app/model/client.dart';

class ClientController extends ResourceController {
  ManagedContext context;
  ClientController(this.context);

  @Operation.get()
  Future<Response> getAllClients() async {
    final query = Query<Client>(context);
    final clientsList = await query.fetch();
    return Response.ok(clientsList);
  }
}
