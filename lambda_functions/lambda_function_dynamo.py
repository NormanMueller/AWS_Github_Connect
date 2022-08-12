import json
import boto3

client = boto3.client('dynamodb')

def lambda_handler(event, context):
  userid, gametitels  = (event.get("body").get("UserId"), event.get("body").get("GameTitle"))
  request_data = client.get_item(
    TableName='GameScores',
    Key={
        'UserId': {'S': userid},
        'GameTitle': {'S': gametitels}
    
    }
  )

  

  response = {
      'statusCode': 200,
      'body': json.dumps(request_data),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
  }
  
  return response