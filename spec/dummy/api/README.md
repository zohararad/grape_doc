# API Documentation for <span>Api::Ping</span>

## GET: /api/v1/pings.json

Returns all pings



### Example Usage


```
curl -XGET /api/v1/pings.json
```


## GET: /api/v1/pings/:id.json

Returns a ping


### Request Parameters

* **:id** - [Integer] Ping ID



### Example Usage


```
curl -XGET /api/v1/pings/12.json
```

# API Documentation for <span>Api::Shout</span>

## GET: /api/v1/shouts.json

Returns all shouts



### Example Usage


```
curl -XGET /api/v1/shouts.json
```


## GET: /api/v1/shouts/:id.json

Returns a shout


### Request Parameters

* **:id** - [Integer] Shout ID



### Example Usage


```
curl -XGET /api/v1/shouts/12.json
```


## POST: /api/v1/shouts.json

Create a shout


### Request Parameters

* **:shout** - [String] Shout to create
* **:voice** - [Hash] {:pitch=>"[Integer] Pitch Level"}



### Example Usage


```
curl -XPOST /api/v1/shouts.json -D "{"shout":"A String","voice":{"pitch":12}}"
```


## PUT: /api/v1/shouts/:id.json

Update a shout


### Request Parameters

* **:id** - [Integer] Shout ID
* **:shout** - [String] Shout to update



### Optional Request Parameters

* **:owner** - [Integer] Shout owner ID


### Example Usage


```
curl -XPUT /api/v1/shouts/12.json -D "{"shout":"A String","owner":12}"
```

