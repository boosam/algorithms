# lambda-humbargs

This is an AWS Lambda function.  It is intended to be run within the context of the AWS Lambda Service.  Simply take the
content of the `index.js` and copy it into the body of the lambda function.  When testing this service, use the
following payload:

        {
          "maxIter": 50,
          "problemSize": 2
        }
