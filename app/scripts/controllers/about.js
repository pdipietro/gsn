'use strict';

/**
 * @ngdoc function
 * @name gsnApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the gsnApp
 */
angular.module('gsnApp')
  .controller('AboutCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
