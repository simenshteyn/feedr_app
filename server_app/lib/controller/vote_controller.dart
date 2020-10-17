import 'package:server_app/server_app.dart';
import 'package:server_app/model/client.dart';
import 'package:server_app/model/feedback.dart';
import 'package:server_app/model/servant.dart';
import 'package:server_app/model/vote.dart';
import 'package:shortid/shortid.dart';

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
    Future<Client> createNewClientInDb(
        Client clientData, ManagedContext ctx) async {
      final addClientQuery = Query<Client>(ctx)..values = clientData;
      final client = await addClientQuery.insert();
      return client;
    }

    Future<Client> findClientByPhoneInDb(
        Vote voteData, ManagedContext ctx) async {
      final findByPhoneQuery = Query<Client>(ctx)
        ..where((c) => c.mobilePhone).equalTo(voteData?.client?.mobilePhone);
      final clientFoundedByPhone = await findByPhoneQuery.fetchOne();
      if (clientFoundedByPhone == null) {
        final Client client = await createNewClientInDb(voteData.client, ctx);
        return client;
      } else {
        final Client client = clientFoundedByPhone;
        return client;
      }
    }

    Future<Servant> createNewServantInDb(
        Servant servant, ManagedContext ctx) async {
      final servantQuery = Query<Servant>(context)..values = servant;
      final newServant = await servantQuery.insert();
      return newServant;
    }

    Future<Servant> findServantByName(Vote voteData, ManagedContext ctx) async {
      final servantNameQuery = Query<Servant>(context)
        ..where((s) => s.name).equalTo(voteData?.servant?.name);
      final servantName = await servantNameQuery.fetchOne();
      if (servantName == null) {
        Servant servant = await createNewServantInDb(voteData.servant, ctx);
        return servant;
      } else {
        final Servant servant = servantName;
        return servant;
      }
    }

    Future<Feedback> createFeedback(Vote voteData, ManagedContext ctx) async {
      final feedbackQuery = Query<Feedback>(context)
        ..values = voteData.feedback;
      final newFeedback = await feedbackQuery.insert();
      return newFeedback;
    }

    Client client = await findClientByPhoneInDb(newVote, context);
    Servant servant = await findServantByName(newVote, context);
    Feedback feedback = await createFeedback(newVote, context);
    final shortId = shortid.generate();

    final query = Query<Vote>(context)
      ..values = newVote
      ..values.createdTime = DateTime.now()
      ..values.client.id = client.id
      ..values.servant.id = servant.id
      ..values.feedback.id = feedback.id
      ..values.linkId = shortId;
    final insertedVote = await query.insert();

    return Response.ok(insertedVote);
  }

  @Operation.get('id')
  Future<Response> getVoteById(@Bind.path('id') int id) async {
    final query = Query<Vote>(context)..where((w) => w.id).equalTo(id);
    final vote = await query.fetchOne();

    if (vote == null) {
      return Response.notFound();
    }
    return Response.ok(vote);
  }
}
