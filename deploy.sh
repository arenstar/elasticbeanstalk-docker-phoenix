echo $1 > version
# git add .
# git commit -am $1
# eb deploy

git archive --format=zip HEAD > application.zip

aws s3 cp ./application.zip s3://elasticbeanstalk-us-west-2-hello-phoenix/

aws elasticbeanstalk create-application-version \
  --application-name 'Hello Phoenix' \
  --version-label v$1 \
  --source-bundle S3Bucket=elasticbeanstalk-us-west-2-hello-phoenix,S3Key=application.zip

aws elasticbeanstalk update-environment --application-name 'Hello Phoenix' --environment-name 'production' --version-label v$1

aws elasticbeanstalk describe-environments --application-name 'Hello Phoenix' --environment-name 'production'
