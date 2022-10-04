import 'package:serviceweb/webservice/Lazy/Filter.dart';
import 'package:serviceweb/webservice/Lazy/Sort.dart';
import 'package:serviceweb/webservice/LazyProperty/SortField.dart';

class LazyMap {
  Map<String, Filter>? filters;
  String tableName;
  Sort? sorter;
  int? count;
  int? displaycount;
  int? pageNumber;
  LazyMap(this.tableName) {
    displaycount=1;
    count=10;
    pageNumber=0;
    this.sorter = Sort("", SortField.UNSORTED);
    this.filters = Map();
  }
  getSyntax() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    //liste
    Map<String, String> data1 = Map();
    List<property> liste = [];
    String tests = "";
    // ignore: curly_braces_in_flow_control_structures
    if (filters!.isNotEmpty)
      // ignore: curly_braces_in_flow_control_structures
      filters!.forEach((key, value) {
        property a = property();
        a.propname = key;
        a.value = value.toJson();
        liste.add(a);
      });

    String ssd = "[";
    for (var element in liste) {
      ssd += element.toJson().toString() + ",";
    }
    ssd = ssd.substring(0, ssd.length - 1);
    ssd += "]";
    data["\"properties\""] = ssd;
    return data;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["\"tablename\""] = "\"" + this.tableName.toString() + "\"";
    data["\"filterdata\""] = getSyntax();
    data["\"sortdata\""] = sortToJson();
    data["\"count\""] = "\"" + count.toString() + "\"";
    data["\"pagenumber\""] = "\"" + pageNumber.toString() + "\"";
    data["\"displaycount\""] = "\"" + displaycount.toString() + "\"";

    return data;
  }

  Map<String, dynamic> sortToJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["\"SortType\""] = "\"" + this.sorter!.SortBy!.name.toString() + "\"";
    data["\"field\""] = "\"" + this.sorter!.field.toString() + "\"";

    return data;
  }
}

class property {
  String? propname = "";
  Map? value;
  toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["\"propname\""] = "\"" + propname.toString() + "\"";
    data["\"values\""] = value;
    return data;
  }
}
