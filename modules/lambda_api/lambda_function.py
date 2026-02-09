def handler(event, context):
  name = event.get('name', 'UNKNOWN')
  return {
    'statusCode': 200,
    'inputEvent': event,
    'message': f"Hello, {name}, Lambda API works well."
  }