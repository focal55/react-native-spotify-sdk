/**
 * @providesModule RCTSpotify
 * @flow
 */
'use strict';

var NativeRCTSpotify = require('NativeModules').RCTSpotify;

/**
 * High-level docs for the RCTSpotify iOS API can be written here.
 */

var Spotify = {
  testlog: function(string) {
		console.log("asdsad");
    NativeRCTSpotify.testlog(string);
  }
};

module.exports = Spotify;
