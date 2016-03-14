'use strict';

var inquirer = require('inquirer');
var fs = require('fs');
var sh = require('shelljs');
var path = require('path');
var compose = require('../../compose');
var file = require('../../file');

var handlers = {
  'node.js': node,
  custom: custom
};

module.exports = function create(name) {
  inquirer.prompt([
    {
      type: 'list',
      name: 'template',
      message: 'Which template would you like to use?',
      choices: [
        'custom',
        'node.js'
      ]
    },
    {
      type: 'input',
      name: 'image',
      message: 'What will be the image source for this service?',
      default: path.basename(process.cwd()) + '/' + name + ':latest',
      validate: function(image) {
        return !!image || 'An image source is required';
      }
    },
    {
      type: 'input',
      name: 'base',
      message: 'On what image is this service based on?',
      when: function(answers) {
        return answers.template === 'custom';
      },
      validate: function(base) {
        return !!base || 'A base image is required';
      }
    }
  ], function (answers) {
    var source = __dirname + '/../../../tpl/create/' + answers.template;

    sh.mkdir('-p', name);
    sh.cp(source + '/*', source + '/.*', name);

    file.replace(path.join(name, 'README.md'), {name: name});

    handlers[answers.template](name, answers);

    console.log('New ' + answers.template + ' service create in ' + path.join(process.cwd(), name));
  });
};

function node(name, answers) {
  sh.mkdir('-p', name + '/lib');
  sh.mkdir('-p', name + '/test');
  sh.touch(name + '/lib/.gitkeep');
  sh.touch(name + '/test/.gitkeep');

  compose.addService(name, {
    image: answers.image
  }, {
    build: './' + name,
    command: 'nodemon .',
    volumes: [
      './' + name + '/server.js:/usr/src/app/server.js',
      './' + name + '/lib:/usr/src/app/lib',
      './' + name + '/test:/usr/src/app/test'
    ]
  });
}

function custom(name, answers) {
  fs.writeFileSync(path.join(name, 'Dockerfile'), 'FROM ' + answers.base);

  compose.addService(name, {
    image: answers.image
  }, {
    build: './' + name
  });
}
