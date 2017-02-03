#Development Requirements

1. Install Ruby

2. Set the following envorenment variables should be set in the shared configuration files (~/.aws/credentials and ~/.aws/config) 
  
```
	Add to ~/.aws/credentials
	AWS_ACCESS_KEY_ID = <AWS_ACCESS_KEY_ID>
	AWS_SECRET_ACCESS_KEY = <AWS_SECRET_ACCESS_KEY>

	Add to ~/.aws/config
	AWS_REGION= "us-east-1"

```

3. get the support for the required aws ruby sdk

    ```
    gem install aws-sdk
    ```

# To Run the Programe

 ```
 run   > ruby randomsearch.rb from the command line
 ```

For now the program is hard coded to the find the closed city to bristol 

Bristol’s lat/lon is: 41.6718° N, 72.9493° W