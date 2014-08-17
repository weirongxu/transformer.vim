#!/usr/bin/env node

var fs = require('fs');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
var content = process.argv[2];
var cmd = process.argv[3];
var args = process.argv.slice(4);

var spawn = require('child_process').spawn;
var pro = spawn(
  process.platform === "win32" ? cmd+".cmd" : cmd, args);

pro.stdout.on('data', function (data) {
  process.stdout.write(decoder.write(data));
});

pro.stdout.on('error', function (err) {});

pro.on('error', function(err) {});

pro.on('close', function(code) {});

pro.stdin.on('error', function(err){});

pro.stdin.write(decoder.write(fs.readFileSync(content)));
pro.stdin.end();
