# API Documentation for <span>Api::Public::Yell</span>

## GET: /api/v1/public/yells/:id.json

Return a yell

### Request Parameters

* **:id** - [Integer] yell ID

### Example Usage

```
curl -XGET /api/v1/public/yells/12.json
```

## POST: /api/v1/public/yells.json

Create a yell

### Request Parameters

* **:words** - Array of Hashes:
 * **:phrase** - [String] Phrase to yell

### Example Usage

```
curl -XPOST /api/v1/public/yells.json -D "{"words":[{"phrase":"A String"}]}"
```
