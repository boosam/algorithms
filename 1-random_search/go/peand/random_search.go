package main

import (
	"log"
	"math"
	"strconv"
	"time"
	"math/rand"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"
)

func main() {
	var targetLatitude float64 = 41.6718;
	var targetLongitude float64 = 72.9493;
	var NumIterations int = 500;
	var bestItem Item;
	var bestDistance float64;

	svc := dynamodb.New(session.New(&aws.Config{Region: aws.String("us-east-1")}))
	
	for i := 0; i < NumIterations; i++ {
		rand.Seed(time.Now().Unix())
		randomId := rand.Intn(2895921)

		params := &dynamodb.GetItemInput{
	        Key: map[string]*dynamodb.AttributeValue{
	            "ID": {
	                N: aws.String(strconv.Itoa(randomId)),
	            },
	        },
	        TableName:            aws.String("WorldCities"),
	    }

	    resp, err := svc.GetItem(params)
	  	oneItem := Item{}
	  	err = dynamodbattribute.UnmarshalMap(resp.Item, &oneItem)

	  	longFloat, err := strconv.ParseFloat(oneItem.Longitude, 64);
	  	latFloat, err := strconv.ParseFloat(oneItem.Latitude, 64);
	  	distance := Distance(targetLatitude, targetLongitude, latFloat, longFloat)
	    if err == nil {
	    	//log.Println( oneItem.Latitude )
	    	//log.Println( oneItem.Longitude )
	    	if i == 0 || distance < bestDistance{
				bestItem = oneItem
				bestDistance = distance
			}

	    	//log.Println( distance )
	    }
	}
	log.Println("Closest city:")
	log.Println( bestItem.CityName )
	log.Println( bestItem.CountryCode )
	log.Println( bestDistance )
   	
}

type Item struct {
    ID     int  
    ASCIICityName        string    `dynamo:"ASCIICityName"`
    CityName  string    `dynamo:"CityName"`
    CountryCode   string    `dynamo:"CountryCode"`
    Latitude string    `dynamo:"Latitude"`
    Longitude string    `dynamo:"Longitude"`
    Region string    `dynamo:"Region"`
}


func hsin(theta float64) float64 {
	return math.Pow(math.Sin(theta/2), 2)
}

func Distance(lat1, lon1, lat2, lon2 float64) float64 {
	// convert to radians
  // must cast radius as float to multiply later
	var la1, lo1, la2, lo2, r float64
	la1 = lat1 * math.Pi / 180
	lo1 = lon1 * math.Pi / 180
	la2 = lat2 * math.Pi / 180
	lo2 = lon2 * math.Pi / 180

	r = 6378100 // Earth radius in METERS

	// calculate
	h := hsin(la2-la1) + math.Cos(la1)*math.Cos(la2)*hsin(lo2-lo1)

	return 2 * r * math.Asin(math.Sqrt(h))
}