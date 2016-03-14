'use strict';

var fs = require('fs');
var path = require('path');

module.exports = {
  replace: function(filePath, replacements) {
    var content = fs.readFileSync(path.join(filePath), 'utf-8');

    Object.keys(replacements).forEach(function(key) {
      content = content.replace(new RegExp('#{' + key + '}', 'g'), replacements[key]);
    });

    fs.writeFileSync(filePath, content);
  }
};
