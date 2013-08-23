cssrules = function(){
  var rules={}; var ds=document.styleSheets,dsl=ds.length;
  for (var i=0;i<dsl;++i){
    var dsi=ds[i].cssRules,dsil=dsi.length;
    for (var j=0;j<dsil;++j) rules[dsi[j].selectorText]=dsi[j];
  }
  return rules;
};

css_getclass = function(name,createifnotfound){
  var rules=cssrules();
  if (!rules.hasOwnProperty(name)) throw 'todo:deal_with_notfound_case';
  return rules[name];
};