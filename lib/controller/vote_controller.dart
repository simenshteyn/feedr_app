import 'package:feedr_app/feedr_app.dart';
import 'package:feedr_app/model/client.dart';
import 'package:feedr_app/model/servant.dart';
import 'package:feedr_app/model/vote.dart';

class VoteController extends ResourceController {
  ManagedContext context;
  VoteController(this.context);

  @Operation.get()
  Future<Response> getAllVotes() async {
    final query = Query<Vote>(context);
    final votesList = await query.fetch();
    return Response.ok(votesList);
  }

  @Operation.post()
  Future<Response> addVote(@Bind.body(ignore: ['id']) Vote newVote) async {
    Client client;
    Servant servant;

    final clientPhoneQuery = Query<Client>(context)
      ..where((c) => c.mobilePhone).equalTo(newVote.client.mobilePhone);
    final clientPhone = await clientPhoneQuery.fetchOne();

    if (clientPhone == null) {
      final clientQuery = Query<Client>(context)..values = newVote.client;
      final client = await clientQuery.insert();
    } else {
      final client = clientPhone;
    }

    final servantNameQuery = Query<Servant>(context)
      ..where((s) => s.name).equalTo(newVote.servant.name);
    final servantName = await servantNameQuery.fetchOne();
    if (servantName == null) {
      final servantQuery = Query<Servant>(context)..values = newVote.servant;
      final servant = await servantQuery.insert();
    } else {
      final servant = servantName;
    }

    final query = Query<Vote>(context)
      ..values = newVote
      ..values.createdTime = DateTime.now()
      ..values.client.id = client.id
      ..values.servant.id = servant.id;
    final insertedVote = await query.insert();
    return Response.ok(insertedVote);
  }
}
