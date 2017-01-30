# WorldCities Dataset

This dataset contains many of the world's cities.  This set has any malformed or corrupted rows removed.  The total number of cities in this data set is ~2.9 million.  This dataset has been loaded into dynamodb.  Dynamodb is a schemaless key/value store.  However, it does require one field be made as the partition key.  The partition key is equivalent to a primary key in an RDBMS.

## Schema
The partition key (and the way you will access records) is "ID" of type "Number".  It is unique auto-incremented value.  All fields are optional (besides ID).  The schema of the data is:

```
{
  "ID": Number,
  "ASCIICityName": String,
  "CityName": String,
  "CountryCode": String,
  "Latitude": Number (decimal degrees),
  "Longitude": Number (decimal degrees),
  "Region": String,
  "Population": Number
}
```

## Location of the Data
The data exists in AWS us-east-1 in the WorldCities table.  It also exists in the following Docker image.  While you can, do not build the docker image.  The write performance of the local Dynamo instance is not awesome. The location of the docker image is: rdr.prod.internal.geo.espn.com/espnautomation/prg-lvl-up:2.
To use it locally, execute the following docker command:
```
docker run -d -p <available local port>:8000 rdr.prod.internal.geo.espn.com/espnautomation/prg-lvl-up:2
```
To use the aws cli with the local instance, be sure to include **--endpoint-url='localhost:\<available local port\>'** to each command.

## Haversine Function
The Haversine function is used to calculate the distance between two points on a sphere.  **Make sure that you convert to Radians before entering any of the values into the trig functions (sin,cos,atan2).**

The function in its mathematical form:
```
a = sin²(Δφ/2) + cos φ1 ⋅ cos φ2 ⋅ sin²(Δλ/2)
c = 2 ⋅ atan2( √a, √(1−a) )
d = R ⋅ c
```

The function in JavaScript
```javascript
var R = 6371e3; // metres
var φ1 = lat1.toRadians();
var φ2 = lat2.toRadians();
var Δφ = (lat2-lat1).toRadians();
var Δλ = (lon2-lon1).toRadians();

var a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
        Math.cos(φ1) * Math.cos(φ2) *
        Math.sin(Δλ/2) * Math.sin(Δλ/2);
var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

var d = R * c;
```

You can find calculators and longer discussions [here](http://www.movable-type.co.uk/scripts/latlong.html) and [here](http://andrew.hedges.name/experiments/haversine/), not to mention, [here](https://www.google.com/). :)
