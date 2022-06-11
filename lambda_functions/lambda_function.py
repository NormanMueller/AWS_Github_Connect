import boto3
def lambda_handler(event, context):
    print("himi")
    result = "Hello World and Sky"
    return {
        'statusCode' : 200,
        'body': result
    }