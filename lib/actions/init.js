'use strict';

var path = require('path');
var sh = require('shelljs');
var file = require('../file');

module.exports = function init(folder) {
  folder && sh.mkdir('-p', folder);

  var source = path.normalize(__dirname + '/../../tpl/init');
  var destination = folder ? path.join(process.cwd(), folder) : process.cwd();

  sh.cp(source + '/*', source + '/.*', destination);

  file.replace(path.join(destination, 'README.md'), {name: path.basename(destination)});

  console.log('Project initialized in ' + destination);
};
