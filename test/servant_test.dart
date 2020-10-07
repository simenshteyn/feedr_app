import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  group("GET: ", () {
    test("GET /servant returns 200 OK", () async {
      final response = await harness.agent.get('/servant');
      expect(response.statusCode, 200);
    });
    test("POST, GET /servant/[:id] return 200 OK after request", () async {
      final postResponse = await harness.agent.post('servant', body: {
        'name': 'Hose',
        'rating': 5.0,
      });
      expectResponse(postResponse, 200);
      final servantId = postResponse.body.as<Map>()["id"];
      final getResponse = await harness.agent.get("/servant/$servantId");
      expectResponse(getResponse, 200, body: {
        "id": servantId,
        "name": "Hose",
        "rating": 5.0,
      });
      final putResponse = await harness.agent.put("/servant/$servantId", body: {
        "id": servantId,
        "name": "HoseUpdated",
        "rating": 4.0,
      });
      expectResponse(putResponse, 200, body: {
        "id": servantId,
        "name": "HoseUpdated",
        "rating": 4.0,
      });
      final deleteResponse = await harness.agent.delete("/servant/$servantId");
      expectResponse(deleteResponse, 200, body: {
        "id": servantId,
        "name": "HoseUpdated",
        "rating": 4.0,
      });
      final deleteResponseSecond =
          await harness.agent.delete("/servant/$servantId");
      expect(deleteResponseSecond.statusCode, 404);
    });
  });
}
