import 'package:aqueduct/aqueduct.dart';

class Servant extends ManagedObject<_Servant> implements _Servant {}

class _Servant {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column()
  double rating;
}
