import 'package:aqueduct/aqueduct.dart';

class Client extends ManagedObject<_Client> implements _Client {}

class _Client {
  @primaryKey
  int id;

  @Column(unique: true)
  int clientPhone;

  @Column()
  String clientName;
}
