import 'package:serviceweb/webservice/LazyProperty/FilterField.dart';

class Filter {

  List<dynamic> Values;
  FilterField MatchMode;
Filter(this.MatchMode,this.Values);
  Map<String, dynamic> toJson() {

     Map<String, dynamic> data = new Map<String, dynamic>();
      String syntax="";
      for (var element in this.Values) {
        syntax+= "\""+element.toString()+"\""+",";
      }
     syntax=  syntax.substring(0,syntax.length-1);
        data['\"value\"']="["+syntax+"]";
        data['\"match_mode\"'] ="\"" +this.MatchMode.name.toString()+"\"";
        return data;
    }
}
