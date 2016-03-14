'use strict';

var fs = require('fs');
var yaml = require('js-yaml');

module.exports = {
  addService: function(name, config, override) {
    var configFile = readBase();

    configFile.services[name] = config || null;

    writeBase(configFile);

    if (override) {
      var overrideFile = readOverride();

      overrideFile.services[name] = override;

      writeOverride(overrideFile);
    }
  },

  removeService: function(name) {
    var configFile = readBase();
    var overrideFile = readOverride();

    delete configFile.services[name];
    delete overrideFile.services[name];

    writeBase(configFile);
    writeOverride(overrideFile);
  }
};

function readBase() {
  return normalize(yaml.safeLoad(fs.readFileSync('docker-compose.yml', 'utf-8')));
}

function readOverride() {
  return normalize(yaml.safeLoad(fs.readFileSync('docker-compose.override.yml', 'utf-8')));
}

function writeBase(data) {
  fs.writeFileSync('docker-compose.yml', yaml.safeDump(data));
}

function writeOverride(data) {
  fs.writeFileSync('docker-compose.override.yml', yaml.safeDump(data));
}

function normalize(data) {
  data.services = data.services || {};
  return data;
}
