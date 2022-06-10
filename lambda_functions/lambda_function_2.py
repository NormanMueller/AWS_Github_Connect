import boto3
def lambda_handler(event, context):
    result = "Hello World and Sky hi"
    return {
        'statusCode' : 200,
        'body': result
    }