import 'package:aqueduct/aqueduct.dart';

class Worker extends ManagedObject<_Worker> implements _Worker {}

class _Worker {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column()
  double rating;
}
