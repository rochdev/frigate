'use strict';

var inquirer = require('inquirer');
var compose = require('../../compose');

module.exports = function add(name) {
  inquirer.prompt([
    {
      type: 'input',
      name: 'image',
      message: 'What will be the image source for this service?',
      default: name + ':latest',
      validate: function(image) {
        return !!image || 'An image source is required';
      }
    }
  ], function (answers) {
    compose.addService(name, {
      image: answers.image
    });

    console.log('Service ' + name + ' added');
  });
};
