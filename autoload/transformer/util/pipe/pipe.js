#!/usr/bin/env node

var fs = require('fs');
var content = process.argv[2];
var cmd = process.argv[3];
var args = process.argv.slice(4);

var spawn = require('child_process').spawn;
var pro = spawn(
  process.platform === "win32" ? cmd+".cmd" : cmd, args);

// FIXME js2coffee error
pro.stdout.pipe(process.stdout);
pro.stderr.pipe(process.stderr);

fs.createReadStream(content).pipe(pro.stdin);
