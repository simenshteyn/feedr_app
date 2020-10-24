import 'dart:async';

import 'package:angular/core.dart';
import 'package:client_app/src/todo_list/vote_component.dart';

@Injectable()
class VoteService {
  Future<int> getRating() async => 0;
  Future<List<Remark>> getRemarks() async =>
      [Remark('Мастер был невежлив'), Remark('Плохо подобран вариант'), Remark('Медленная работа')];
    Future<List<Remark>> getBenefits() async =>
      [Remark('Приятная музыка'), Remark('Интересная беседа'), Remark('Вежливость')];
}
