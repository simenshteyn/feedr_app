import 'package:aqueduct/aqueduct.dart';
import 'package:feedr_app/model/vote.dart';

class Client extends ManagedObject<_Client> implements _Client {}

class _Client {
  @primaryKey
  int id;

  @Column()
  String mobilePhone;

  @Column()
  String fullName;

  ManagedSet<Vote> votes;
}
