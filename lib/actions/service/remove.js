'use strict';

var compose = require('../../compose');

module.exports = function remove(name) {
  compose.removeService(name);

  console.log('Service ' + name + ' removed');
};
