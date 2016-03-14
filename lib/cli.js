'use strict';

var inquirer = require('inquirer');
var program = require('commander');

program
  .command('init [folder]')
  .description('initialize a new docker-compose project')
  .action(require('./actions/init'));

program
  .command('service:create <name>')
  .description('create a new service')
  .action(require('./actions/service/create'));

program
  .command('service:add <name>')
  .description('add an external service')
  .action(require('./actions/service/add'));

program
  .command('service:remove <name>')
  .description('remove a service')
  .action(require('./actions/service/remove'));

program.parse(process.argv);
