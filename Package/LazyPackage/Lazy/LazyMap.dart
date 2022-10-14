// ignore_for_file: unnecessary_this

import 'package:flutter/foundation.dart';
import 'package:serviceweb/webservice/Lazy/Filter.dart';
import 'package:serviceweb/webservice/Lazy/Sort.dart';
import 'package:serviceweb/webservice/LazyProperty/SortField.dart';

// ignore_for_file: curly_braces_in_flow_control_structures
class LazyMap {
  Map<String, Filter>? filters;
  String tableName;
  Sort? sorter;
  int? count;
  int? displaycount;
  int? pageNumber;
  String? primarykeyname;
  Map<String, dynamic> object =Map();
  LazyMap(this.tableName) {
    displaycount = 1;
    count = 10;
    pageNumber = 0;
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
    if (tableName.isNotEmpty)
      data["\"tablename\""] = "\"" + this.tableName.toString() + "\"";
    else 
      return Map();
    if (filters != null && filters!.isNotEmpty)
      data["\"filterdata\""] = getSyntax();
    if (sorter != null) data["\"sortdata\""] = sortToJson();
    if (count != null) data["\"count\""] = "\"" + count.toString() + "\"";
    if (pageNumber != null)
      data["\"pagenumber\""] = "\"" + pageNumber.toString() + "\"";
    if (displaycount != null)
      data["\"displaycount\""] = "\"" + displaycount.toString() + "\"";
    if (object.isNotEmpty)
      data["\"object\""] = object.toString();
    if (primarykeyname != null)
      data["\"primarykeyname\""] = "\"" + primarykeyname! + "\"";
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
