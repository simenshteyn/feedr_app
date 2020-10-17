import 'package:server_app/server_app.dart';
import 'package:server_app/model/feedback.dart';

class FeedbackController extends ResourceController {
  ManagedContext context;
  FeedbackController(this.context);

  @Operation.get()
  Future<Response> getAllFeedback() async {
    final query = Query<Feedback>(context);
    final feedbackList = await query.fetch();
    return Response.ok(feedbackList);
  }

  @Operation.get('id')
  Future<Response> getFeedbackById(@Bind.path('id') int id) async {
    final query = Query<Feedback>(context)..where((f) => f.id).equalTo(id);
    final feedback = await query.fetchOne();

    if (feedback == null) {
      return Response.notFound();
    }
    return Response.ok(feedback);
  }

  @Operation.post()
  Future<Response> addFeedBack(
      @Bind.body(ignore: ['id']) Feedback newFeedback) async {
    final query = Query<Feedback>(context)..values = newFeedback;
    final insertedFeedback = await query.insert();
    return Response.ok(insertedFeedback);
  }

  @Operation.put('id')
  Future<Response> updateFeedbackById(@Bind.path('id') int id,
      @Bind.body(ignore: ['id']) Feedback feedbackUpdate) async {
    final query = Query<Feedback>(context)
      ..values = feedbackUpdate
      ..where((f) => f.id).equalTo(id);
    final updatedFeedback = await query.updateOne();
    if (updatedFeedback == null) {
      return Response.notFound();
    }
    return Response.ok(updatedFeedback);
  }

  @Operation.delete('id')
  Future<Response> deleteFeedbackById(@Bind.path('id') int id) async {
    final query = Query<Feedback>(context)..where((f) => f.id).equalTo(id);
    final feedback = await query.fetchOne();
    final deletedFeedback = await query.delete();

    if (deletedFeedback == 0) {
      return Response.notFound();
    }
    return Response.ok(feedback);
  }
}
