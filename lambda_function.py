# pip install twilio
# pip install requests
# pip install giphy_client

# imports
import twilio
import requests
from twilio.rest import Client
import os

# env variables
twilio_number = os.environ['twilio_number']
account_sid = os.environ['account_sid']
auth_token = os.environ['auth_token']
giphy_key = os.environ['giphy_key']
first_friend_number = os.environ['first_friend_number']
second_friend_number = os.environ['second_friend_number']

# get gif
def lambda_handler(event, context):
	payload = {'s': 'funny dog', 'api_key': giphy_key}
	r = requests.get('http://api.giphy.com/v1/gifs/translate', params=payload)
	gif = r.json()['data']['images']['original']['url']

	# send gif
	client = Client(account_sid, auth_token)
	numbers_to_text = [first_friend_number, second_friend_number]
	for number in numbers_to_text:
		client.messages.create(to=number, from_=twilio_number, media_url=gif)
	print("gif sent")
