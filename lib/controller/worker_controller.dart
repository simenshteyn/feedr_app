import 'package:feedr_app/feedr_app.dart';
import 'package:feedr_app/model/worker.dart';

class WorkerController extends ResourceController {
  ManagedContext context;
  WorkerController(this.context);

  @Operation.get('id')
  Future<Response> getWorkerById(@Bind.path('id') int id) async {
    final query = Query<Worker>(context)..where((w) => w.id).equalTo(id);
    final worker = query.fetchOne();

    if (worker == null) {
      return Response.notFound();
    }
    return Response.ok(worker);
  }

  @Operation.post()
  Future<Response> addWorker(
      @Bind.body(ignore: ['id']) Worker newWorker) async {
    final query = Query<Worker>(context)..values = newWorker;
    final insertedWorker = await query.insert();
    return Response.ok(insertedWorker);
  }
}
