import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  group("GET: ", () {
    test("GET /feedback returns 200 OK", () async {
      final response = await harness.agent.get('/feedback');
      expect(response.statusCode, 200);
    });

    test("POST, GET, PUT, DELETE /feedback/[:id] return 200 OK after request", () async {
      final postResponse = await harness.agent.post('feedback', body: {
        "message": "Some feedback message",
        "stars": 4,
      });
      expectResponse(postResponse, 200);
      final feedbackId = postResponse.body.as<Map>()["id"];
      final getResponse = await harness.agent.get("/feedback/$feedbackId");
      expectResponse(getResponse, 200, body: {
        "id": feedbackId,
        "message": "Some feedback message",
        "stars": 4,
      });
      final putResponse =
          await harness.agent.put("/feedback/$feedbackId", body: {
        "id": feedbackId,
        "message": "Some feedback message updated",
        "stars": 5,
      });
      expectResponse(putResponse, 200, body: {
        "id": feedbackId,
        "message": "Some feedback message updated",
        "stars": 5,
      });
      final deleteResponse =
          await harness.agent.delete("/feedback/$feedbackId");
      expectResponse(deleteResponse, 200, body: {
        "id": feedbackId,
        "message": "Some feedback message updated",
        "stars": 5,
      });
      final deleteResponseSecond =
          await harness.agent.delete("/feedback/$feedbackId");
      expect(deleteResponseSecond.statusCode, 404);
    });
  });
}
