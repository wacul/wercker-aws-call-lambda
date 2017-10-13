Wercker step for aws lambda invoke
=======================

# Example

```
deploy:
  steps:
    - wacul/aws-lambda-invoke:
        key: $AWS_ACCESS_KEY_ID
        secret: $AWS_SECRET_ACCESS_KEY
        region: $AWS_DEFAULT_REGION
        function-name: function
        payload: >-
          {"pay":"load"}
```


