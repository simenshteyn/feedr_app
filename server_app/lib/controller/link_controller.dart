import 'package:feedr_app/feedr_app.dart';
import 'package:feedr_app/model/vote.dart';

class LinkController extends ResourceController {
  ManagedContext context;
  LinkController(this.context);

  @Operation.get('link')
  Future<Response> getVoteById(@Bind.path('link') String link) async {
    final query = Query<Vote>(context)..where((v) => v.linkId).equalTo(link);
    final vote = await query.fetchOne();

    if (vote == null) {
      return Response.notFound();
    }
    return Response.ok(vote);
  }
}
