import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  group("GET: ", () {
    test("GET /worker retutrn 200 OK", () async {
      final response = await harness.agent.get('/worker');
      expect(response.statusCode, 405);
    });
    test("GET /words/1 return 200 OK after request", () async {
      await harness.agent.post('worker', body: {
        'name': 'Hose',
      });
      final response = await harness.agent.get('/wokers/1');
      expect(response.statusCode, 200);
    });
  });
}
