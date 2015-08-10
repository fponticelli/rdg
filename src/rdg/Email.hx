package rdg;

using StringTools;

class Email {
  public static var patterns = [
    "{name}@{company}.com",
    "{surname}@{company}.com",
    "{name}.{surname}@{company}.com",
    "{name}{surname}@{company}.com"
  ];
  public static function generator(?patterng : Void -> String, ?nameg : Void -> String, ?surnameg : Void -> String, ?companyg : Void -> String) {
    if(null == patterng) patterng = new GPicker(patterns).generate;
    if(null == nameg)    nameg    = Name.generator();
    if(null == surnameg) surnameg = Surname.generator();
    if(null == companyg) companyg = Company.generator();

    return function()
      return emailFormat(patterng(), { name : nameg(), surname : surnameg(), company : companyg() });
  }

  static function emailFormat(pattern : String, params : Dynamic) {
    var result = pattern;
    for(field in Reflect.fields(params)) {
      var v : String = Reflect.field(params, field);
      result = result.replace("{"+field+"}", cleanup(v));
    }
    return result;
  }

  static var cleaner = ~/['"&]+/ig;
  static var dasher = ~/[ .]+/ig;
  static function cleanup(s : String)
    return dasher.replace(cleaner.replace(s, ''), '-').toLowerCase();
}
