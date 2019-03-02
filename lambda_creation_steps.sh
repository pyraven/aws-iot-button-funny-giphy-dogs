# these steps assume you have the correct permissions to do this, 
# check your IAM policies if you get any permission erros

# create lambda package
mkdir dogbutton
cd dogbutton
virtualenv --python=/usr/local/bin/python3.7 venv
source venv/bin/activate
pip install twilio
pip install requests
pip install giphy_client
deactivate
cd venv/lib/python3.7/site-packages
vi lambda_function.py
<copy + paste code from lambda_function.py file in repo>
zip -r9 lambda_package.zip .

# create lambda
aws lambda create-function --function-name "dogbutton" --runtime "python3.7" --role "arn:aws:iam::000000000000:role/lambda_basic_execution" --handler "lambda_function.lambda_handler" --timeout 5 --zip-file "fileb://./lambda_package.zip" --region "us-west-2"

# if you neeed to update lambda with a new package, remove the previous zip
# in the same directory, re-zip the package up, and upload using this:

aws lambda update-function-code --function-name "dogbutton" --zip-file "fileb://./lambda_package.zip" --region "us-west-2"