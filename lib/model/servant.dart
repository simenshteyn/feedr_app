import 'package:aqueduct/aqueduct.dart';
import 'package:feedr_app/model/vote.dart';

class Servant extends ManagedObject<_Servant> implements _Servant {}

class _Servant {
  @primaryKey
  int id;


  String name;


  double rating;

  ManagedSet<Vote> votes;
}
