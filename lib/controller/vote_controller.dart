import 'package:feedr_app/feedr_app.dart';
import 'package:feedr_app/model/client.dart';
import 'package:feedr_app/model/feedback.dart';
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

    final query = Query<Vote>(context)
      ..values = newVote
      ..values.createdTime = DateTime.now()
      ..values.client.id = client.id
      ..values.servant.id = servant.id
      ..values.feedback.id = feedback.id;
    final insertedVote = await query.insert();

    // final updateFeedbackQuery = Query<Feedback>(context)
    //   ..values = feedback
    //   ..values.vote.id = insertedVote.id
    //   ..where((f) => f.id).equalTo(feedback.id);
    // final createdVote = await updateFeedbackQuery.updateOne();

    return Response.ok(insertedVote);
  }
}
