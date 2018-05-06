# icflix 

* Ruby version - `2.5.1`

* Rails version - `5.2.0`

* Install all dependencies - `bundle install`

* Database - `pg`

* Database creation - `rails db:create`

* Database initialization - `rails db:migrate`

* To load dummy data - `rails db:seed`

* How to run the test suite - `rspec`

#### Api Structure

* Header  - `{Authorization: Token tenant_token}`

* Sample api_key - `pnf-Og17ylratySpeukB0w` `wVZsX5wxZ9o-4OB6MRklXQ`

```
  get /api/v1/questions

    [
    {
        "id": id,
        "description": "Question",
        "public_answers": [
            {
                "id": id,
                "description": "Answer 1",
                "is_personal": false,
                "provider": {
                    "id": 1,
                    "name": "Name"
                }
            },
            ...
        ],
        "asker": {
            "id": 1,
            "name": "Name"
        }
    },
    ...
    }]
```


```
  get /api/v1/questions/search?query=query_string

  [
    {
        "id": id,
        "description": "Question",
        "public_answers": [
            {
                "id": id,
                "description": "Answer 1",
                "is_personal": false,
                "provider": {
                    "id": 1,
                    "name": "Name"
                }
            },
            ...
        ],
        "asker": {
            "id": 1,
            "name": "Name"
        }
    },
    ...
    }]
```

