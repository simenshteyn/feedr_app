import 'package:feedr_app/feedr_app.dart';
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
}
