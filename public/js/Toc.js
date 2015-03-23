
/** @jsx React.DOM */
var ModuleGroup, ModuleItem, Toc, gkeys, hash, keys;

hash = function(s) {
  return s.split("").reduce(function(a, b) {
    a = ((a << 5) - a) + b.charCodeAt(0);
    return a & a;
  }, 0);
};

keys = {};

gkeys = {};

ModuleItem = React.createClass({
  render: function() {
    var url;
    url = "/module/" + this.props.module.name + ".html";
    return <div className="item">
      <a href={url} className="ui inverted small header">{this.props.module.title}</a>
    </div>;
  }
});

ModuleGroup = React.createClass({
  render: function() {
    var items, module;
    items = (function() {
      var _i, _len, _ref, _results;
      _ref = this.props.group.modules;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        module = _ref[_i];
        _results.push(<ModuleItem key={module.name} module={module} />);
      }
      return _results;
    }).call(this);
    return <div className="item">
      <i className="home icon" />
      <a href="" className="ui small inverted header">{this.props.group.name}</a>
      <div className="modules menu">
      {items}
      </div>
    </div>;
  }
});

Toc = React.createClass({
  render: function() {
    var group, groups, items, module, modules, name;
    groups = {};
    items = (function() {
      var _ref, _results;
      _ref = this.props.data;
      _results = [];
      for (name in _ref) {
        module = _ref[name];
        group = module.index ? name : name.split('/').slice(0, -1).join('/');
        if (groups[group] == null) {
          groups[group] = [];
        }
        _results.push(groups[group].push(module));
      }
      return _results;
    }).call(this);
    groups = (function() {
      var _results;
      _results = [];
      for (name in groups) {
        modules = groups[name];
        if (modules.length === 0) {
          continue;
        }
        group = {
          name: name,
          modules: modules
        };
        _results.push(<ModuleGroup key={group.name} group={group} />);
      }
      return _results;
    })();
    return <div className="toc ui left vertical inverted sidebar menu uncover">
      <div className="ui fluid search loading item">
        <div className="ui icon input">
          <input className="prompt" placeholder="Filter..." type="text" />
          <i className="search icon" />
        </div>
      </div>
      <a className="item"><i className="home icon" /><span className="text">Home</span></a>
      {groups}
    </div>;
  }
});
