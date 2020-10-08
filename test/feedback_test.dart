import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  group("GET: ", () {
    test("GET /feedback returns 200 OK", () async {
      final response = await harness.agent.get('/feedback');
      expect(response.statusCode, 200);
    });
  });
}
