import 'package:feedr_app/feedr_app.dart';
import 'package:feedr_app/model/feedback.dart';

class FeedbackController extends ResourceController {
  ManagedContext context;
  FeedbackController(this.context);

  @Operation.get()
  Future<Response> getAllFeedback() async {
    final query = Query<Feedback>(context);
    final feedbackList = await query.fetch();
    return Response.ok(feedbackList);
  }
}
