
/** @jsx React.DOM */
var Command, Commands;

Command = React.createClass({
  render: function() {
    return <div className="item" data-value={this.props.command}>
      {this.props.command}
    </div>;
  }
});

Commands = React.createClass({
  render: function() {
    var command, commands, i, innername, innernames, j, name, names, _i, _j, _ref, _ref1;
    commands = null;
    names = this.props.name.split('/');
    for (i = _i = _ref = names.length - 1; _ref <= 1 ? _i <= 1 : _i >= 1; i = _ref <= 1 ? ++_i : --_i) {
      if (commands) {
        break;
      }
      name = names.slice(0, i).join('/');
      commands = this.props.commands[name];
      if (commands) {
        break;
      }
      if (i === names.length - 1) {
        innernames = names[i].split('_');
        for (j = _j = _ref1 = innernames.length - 1; _ref1 <= 1 ? _j <= 1 : _j >= 1; j = _ref1 <= 1 ? ++_j : --_j) {
          innername = name + '/' + innernames.slice(0, j).join('_');
          commands = this.props.commands[innername];
          if (commands) {
            break;
          }
        }
      }
    }
    if (!commands) {
      return false;
    }
    commands = (function() {
      var _k, _len, _results;
      _results = [];
      for (_k = 0, _len = commands.length; _k < _len; _k++) {
        command = commands[_k];
        _results.push(<Command key={command} command={command} />);
      }
      return _results;
    })();
    return <div className="ui selection dropdown">
      <input name="" type="hidden" />
      <div className="default text">Available Commands</div>
      <i className="dropdown icon" />
      <div className="menu">
        {commands}
      </div>
    </div>;
  },
  componentDidMount: function() {
    return $(this.getDOMNode()).dropdown({
      transition: 'drop'
    });
  }
});
