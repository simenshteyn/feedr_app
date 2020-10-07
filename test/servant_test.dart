import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  group("GET: ", () {
    test("GET /servant retutrn 200 OK", () async {
      final response = await harness.agent.get('/servant');
      expect(response.statusCode, 200);
    });
    test("GET /servant/1 return 200 OK after request", () async {
      await harness.agent.post('servant', body: {
        'name': 'Hose',
        'rating': '5.0',
      });
      final response = await harness.agent.get('/servant/1');
      expect(response.statusCode, 200);
    });
  });
}
