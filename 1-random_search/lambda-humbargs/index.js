'use strict';

console.log('Loading function');

exports.handler = (event, context, callback) => {
    console.log('We received ' + JSON.stringify(event));

    function search(searchSpace, maxIter ) {
      var best = null;
      for(var i = 0; i < maxIter; i++) {
        var iteration = i + 1;
        var candidate = {};
        candidate.vector = randomVector(searchSpace);
        candidate.cost = objectiveFunction(candidate.vector);

        if (best === null || candidate.cost < best.cost) {
          best = candidate;
        }
        console.log(" > candidate=" + candidate.cost + ", best=" + best.cost );
      }
      return best;
    }

    function randomVector(minmax) {
      //console.log(minmax.length)
      var vector = [];
      for(var i = 0; i < minmax.length; i++){
        vector.push(minmax[i][0] + ((minmax[i][1] - minmax[i][0]) * Math.random()));
      }
      return vector;
    }

    function objectiveFunction(vector) {
      var sum = 0;
      vector.forEach(function (item, index, vector) {
        sum = (sum + item) + (Math.pow(item, 2.0));
      });
      return sum;
    }

    var searchSpace = [];
    for(var i = 0; i < event.problemSize; i++) {
      searchSpace.push([5, -5]);
    }

    var best = search(searchSpace, event.maxIter);
    console.log("Done. Best Solution: c=" + best.cost + ", v=" + best.vector);

    callback(null, best.cost);
};
